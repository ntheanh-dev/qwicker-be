import json
from django.db import transaction, IntegrityError
from django.db.models import Prefetch, Q, FilteredRelation
from django.http import HttpResponse
from rest_framework import viewsets, generics, permissions, parsers, status
from .models import *
from .paginator import JobPaginator
from .perms import *
from .serializers import *
from rest_framework.decorators import action, permission_classes
from rest_framework.views import Response
from django.core.cache import cache
import cloudinary.uploader
from datetime import datetime
from django.utils import timezone
import random
from .ultils import *
from deliveryapp.celery import send_otp, send_apologia


# Create your views here.
class BasicUserViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView):
    queryset = BasicUser.objects.all()
    serializer_class = BasicUserSerializer
    parser_classes = [parsers.MultiPartParser, ]

    @action(methods=['get', 'put'], detail=False, url_path='current-user')
    def current_user(self, request):
        u = request.user
        if u.role == User.Roles.BASIC_USER:
            if request.method.__eq__('PUT'):
                for k, v in request.data.items():
                    setattr(u, k, v)
                u.save()
            return Response(BasicUserSerializer(u, context={'request': request}).data, status=status.HTTP_200_OK)
        else:
            return Response({}, status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['post'], detail=False, url_path='sent-otp')
    def sent_otp(self, request):
        if request.data.get('email') and request.data.get('first_name'):
            otp = random.randint(1000, 9999)
            receiver = request.data.get('email')
            first_name = request.data.get('first_name')
            send_otp.delay(receiver, otp, first_name)
            cache.set(receiver, str(otp), 60)
            return Response({}, status=status.HTTP_200_OK)
        else:
            return Response({'Email and first_name are required '}, status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['post'], detail=False, url_path='verify-email')
    def verify_email(self, request):
        if request.data.get('email') and request.data.get('otp'):
            email = request.data.get('email')
            opt = request.data.get('otp')
            cache_opt = cache.get(email)
            if cache_opt:
                if cache_opt == opt:
                    return Response({'Email is valid'}, status=status.HTTP_200_OK)
                else:
                    return Response({'incorrect otp'}, status=status.HTTP_400_BAD_REQUEST)
            else:
                return Response({'otp time is expired'}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({'Email and OTP are required'}, status=status.HTTP_400_BAD_REQUEST)


class ShipperViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView):
    queryset = Shipper.objects.all()
    serializer_class = ShipperSerializer

    @action(methods=['get', 'put'], detail=False, url_path='current-user')
    def current_user(self, request):
        u = request.user
        if u.role == User.Roles.SHIPPER:
            if request.method.__eq__('PUT'):
                for k, v in request.data.items():
                    setattr(u, k, v)
                u.save()
            return Response(BasicUserSerializer(u, context={'request': request}).data, status=status.HTTP_200_OK)
        else:
            return Response({}, status=status.HTTP_400_BAD_REQUEST)

    @transaction.atomic()
    def create(self, request, *args, **kwargs):
        data = request.data
        try:
            basic_account_info = {key: data.getlist(key) if len(data.getlist(key)) > 1 else data[key] for key in data}
            selected_fields = ['cmnd', 'vehicle', 'vehicle_number']
            additional_info = {key: basic_account_info.pop(key) for key in selected_fields}

            s = ShipperSerializer(data=basic_account_info)
            s.is_valid(raise_exception=True)
            s_instance = s.save()

            additional_info['user'] = s_instance.id
            sm = ShipperMoreSerializer(data=additional_info)
            sm.is_valid(raise_exception=True)
            sm.save()
            return Response(ShipperSerializer(s_instance).data, status=status.HTTP_201_CREATED)
        except:
            return Response({'invalid fields were sent'}, status=status.HTTP_400_BAD_REQUEST)


class ShipperMoreViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView):
    queryset = ShipperMore.objects.all()
    serializer_class = ShipperMoreSerializer


class VehicleViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Vehicle.objects.all()
    serializer_class = VehicleSerializer


class ProductViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    parser_classes = [parsers.MultiPartParser, ]


class ProductCategoryViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = ProductCategory.objects.all()
    serializer_class = ProductCategorySerializer


class JobViewSet(viewsets.ViewSet, generics.CreateAPIView, generics.ListAPIView, generics.RetrieveAPIView):
    queryset = Job.objects.select_related('shipment', 'shipment__pick_up', 'shipment__delivery_address', 'product',
                                          'product__category', 'payment',
                                          'payment__method',
                                          'vehicle').order_by('created_at')
    serializer_class = JobSerializer
    pagination_class = JobPaginator
    permission_classes = [BasicUserOwnerJob]

    def create(self, request, *args, **kwargs):
        cleaned_data = {}
        for key, value in request.POST.items():
            # Split the keys on '[' and ']'
            keys = key.split('[')
            keys = [key.rstrip(']') for key in keys]

            # Recursive function to set the nested values in the dictionary
            def set_nested_value(dictionary, keys, value):
                if len(keys) == 1:
                    dictionary[keys[0]] = value
                else:
                    if keys[0] not in dictionary:
                        dictionary[keys[0]] = {}
                    set_nested_value(dictionary[keys[0]], keys[1:], value)

            set_nested_value(cleaned_data, keys, value)
        try:
            with transaction.atomic():
                # Product
                product = Product.objects.create(**cleaned_data['product'])
                # Address
                pick_up = Address.objects.create(**cleaned_data['pick_up'])
                # Address
                delivery_address = Address.objects.create(**cleaned_data['delivery_address'])
                # Shipment
                shipment_data = cleaned_data['shipment']
                shipment_data['pick_up_id'] = pick_up.id
                shipment_data['delivery_address_id'] = delivery_address.id
                shipment = Shipment.objects.create(**shipment_data)
                # Payment
                cleaned_data['payment']['is_poster_pay'] = bool(cleaned_data['payment']['is_poster_pay'].lower())
                payment = Payment.objects.create(**cleaned_data['payment'])
                # Job
                job = cleaned_data['order']
                job['poster_id'] = request.user.id
                job['product_id'] = product.id
                job['payment_id'] = payment.id
                job['shipment_id'] = shipment.id
                #
                job_instance = Job.objects.create(**job)
                job_seria = JobSerializer(data=job_instance, context={'request': request})
                job_seria.is_valid()
                return Response(job_seria.data, status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)
            return Response(e, status=status.HTTP_400_BAD_REQUEST)

    def list(self, request, *args, **kwargs):
        query = self.get_queryset().filter(poster=request.user.id)
        job_status = request.query_params.get('status')
        if job_status:
            status_list = [s for s in job_status.split(',')]
            query = query.filter(status__in=status_list)

            if Job.Status.DONE in status_list or Job.Status.WAITING_PAY in status_list:
                query = query.select_related('winner')
                self.serializer_class = JobDetailSerializer
        query = self.paginate_queryset(query)
        jobs = self.serializer_class(data=query, many=True)
        jobs.is_valid()
        return Response(self.get_paginated_response(jobs.data), status=status.HTTP_200_OK)

    def retrieve(self, request, *args, **kwargs):
        query = self.get_queryset().filter(id=int(kwargs['pk']), poster=request.user.id).first()
        return Response(self.serializer_class(query).data, status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='assign')
    def assign(self, request, pk=None):
        shipper_id = request.data.get('shipper')
        if shipper_id:
            job = Job.objects.filter(id=pk).prefetch_related('auction_job')
            shippers = [auction.shipper for auction in job[0].auction_job.select_related('shipper').all()]
            try:
                for shipper in shippers:
                    send_apologia.delay(shipper.email)
            except Exception as e:
                return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            setattr(job[0], 'winner_id', int(shipper_id))
            j = Job.objects.get(pk=pk)
            j.status = Job.Status.WAITING_SHIPPER
            j.winner_id = shipper_id
            j.save(update_fields=['status', 'winner_id'])
            return Response(JobSerializer(job[0], context={'request': request}).data, status=status.HTTP_200_OK)
        else:
            return Response({'shipper_id is required'}, status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['get'], detail=True, url_path='list-shipper')
    def list_shipper(self, request, pk):
        user = request.user
        job = Job.objects.filter(poster_id=user.id, id=pk).prefetch_related('auction_job')
        if job:
            shipper = [auction.shipper for auction in job[0].auction_job.select_related('shipper').all()]
            return Response(ShipperSerializer(shipper, many=True).data, status=status.HTTP_200_OK)
        else:
            return Response([], status=status.HTTP_404_NOT_FOUND)

    @action(methods=['post'], detail=True, url_path='feedback')
    def feedback(self, request, pk=None):
        job = Job.objects.get(pk=pk)
        user = request.user
        if job.poster.id == user.id:
            try:
                feedback_data = request.data.dict()
                feedback_data['job'] = job.id
                feedback_data['user'] = request.user.id
                fb = FeedbackSerializer(data=feedback_data)
                fb.is_valid(raise_exception=True)
                fb.save()
                return Response(fb.data, status=status.HTTP_201_CREATED)
            except Exception as e:
                return Response(status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response(status=status.HTTP_403_FORBIDDEN)


class ShipperJobViewSet(viewsets.ViewSet, generics.RetrieveAPIView):
    queryset = Job.objects.select_related('shipment', 'shipment__pick_up', 'shipment__delivery_address', 'product',
                                          'product__category', 'payment',
                                          'payment__method',
                                          'vehicle')
    serializer_class = JobSerializer
    pagination_class = JobPaginator
    permission_classes = [IsShipper]

    @action(methods=['get'], detail=False, url_path='find')
    def find(self, request):
        query = self.get_queryset().filter(
            ~Q(auction_job__shipper_id=request.user.id) & Q(status=Job.Status.FINDING_SHIPPER))
        query = self.paginate_queryset(query)
        jobs = self.serializer_class(data=query, many=True)
        jobs.is_valid()
        return Response(self.get_paginated_response(jobs.data), status=status.HTTP_200_OK)

    def retrieve(self, request, *args, **kwargs):
        try:
            query = Job.objects.get(pk=int(kwargs['pk']))
            data = self.serializer_class(query).data
            shipper_count = Auction.objects.filter(job__id=int(kwargs['pk'])).count()
            data['shipper_count'] = shipper_count
            return Response(data, status=status.HTTP_200_OK)
        except Job.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['post'], detail=True, url_path='join')
    def join(self, request, pk=None):
        job = Job.objects.get(pk=pk)
        if job.status == Job.Status.FINDING_SHIPPER:
            try:
                Auction.objects.create(job_id=pk, shipper_id=request.user.id)
                return Response({"join successfully"}, status=status.HTTP_201_CREATED)
            except IntegrityError:
                return Response({"you've already joined this job"}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({"job is not in finding shipper state"}, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['get'], detail=False, url_path='my-jobs')
    def my_jobs(self, request):
        query = self.get_queryset().filter(Q(auction_job__shipper_id=request.user.id))
        job_status = request.query_params.get('status')
        if job_status:
            status_list = [int(s) for s in job_status.split(',')]
            query = query.filter(status__in=status_list)
        query = self.paginate_queryset(query)
        jobs = self.serializer_class(data=query, many=True)
        jobs.is_valid()
        return Response(self.get_paginated_response(jobs.data), status=status.HTTP_200_OK)

    @action(methods=['post'], detail=True, url_path='complete')
    def complete(self, request, pk=None):
        job = Job.objects.filter(id=pk).select_related('payment', 'payment__method').first()
        if job.status == Job.Status.WAITING_SHIPPER:
            if job.payment.method.name in ['Momo']:
                if job.payment.payment_date is None:
                    job.status = Job.Status.WAITING_PAY
                    job.save(update_fields=['status'])
                # is paid
                else:
                    job.status = Job.Status.DONE
                    job.save(update_fields=['status'])
            # cash
            else:
                job.payment.payment_date = timezone.now()
                job.payment.save(update_fields=['payment_date'])

                job.status = Job.Status.DONE
                job.save(update_fields=['status'])

            return Response({"complete!!!"}, status=status.HTTP_200_OK)
        else:
            return Response({"job is not in waiting shipper state"}, status=status.HTTP_400_BAD_REQUEST)


class ShipmentViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Shipment.objects.all()
    serializer_class = ShipmentSerializer


class AddressViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Address.objects.all()
    serializer_class = AddressSerializer


class PaymentViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Payment.objects.all()
    serializer_class = PaymentSerializer


class PaymentMethodViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = PaymentMethod.objects.all()
    serializer_class = PaymentMethodSerializer


class AuctionViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Auction.objects.all()
    serializer_class = AuctionSerializer

    def get_permissions(self):
        if self.action in ['create']:
            self.permission_classes = [IsShipper]
        return super(AuctionViewSet, self).get_permissions()

    def create(self, request, *args, **kwargs):
        job = request.data.get('job')
        shipper = request.data.get('shipper')
        if job and shipper is not None:
            try:
                a = Auction.objects.create(job_id=job, shipper_id=shipper)
                return Response(AuctionSerializer(a).data, status=status.HTTP_201_CREATED)
            except IntegrityError:
                return Response(data={'error_msg': "job or shipper does not exist!"},
                                status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response(data={'error_msg': "Job and shipper are required!!!"}, status=status.HTTP_400_BAD_REQUEST)
