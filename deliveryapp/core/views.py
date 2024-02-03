import json
from django.db import transaction, IntegrityError
from django.http import HttpResponse
from rest_framework import viewsets, generics, permissions, parsers, status
from .models import *
from .perms import *
from .serializers import *
from rest_framework.decorators import action
from rest_framework.views import Response
from django.core.cache import cache
import cloudinary.uploader
from datetime import datetime
import random
from .ultils import *
from deliveryapp.celery import send_mail_func


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
            send_mail_func.delay(receiver, otp, first_name)
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


class JobViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Job.objects.all()
    serializer_class = JobSerializer

    def get_permissions(self):
        if self.action in ['create']:
            self.permission_classes = [IsBasicUser]
        if self.action in ['my_jobs']:
            self.permission_classes = [BasicUserOwnerJob]
        return super(JobViewSet, self).get_permissions()

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
                product = ProductSerializer(data=cleaned_data['product'])
                product.is_valid(raise_exception=True)
                product.save()
                # Address
                pick_up = AddressSerializer(data=cleaned_data['pick_up'])
                pick_up.is_valid(raise_exception=True)
                pick_up.save()
                # Address
                delivery_address = AddressSerializer(data=cleaned_data['delivery_address'])
                delivery_address.is_valid(raise_exception=True)
                delivery_address.save()
                # Shipment
                s = cleaned_data['shipment']
                s['pick_up'] = pick_up.data['id']
                s['delivery_address'] = delivery_address.data['id']
                shipment = ShipmentSerializer(data=s)
                shipment.is_valid(raise_exception=True)
                shipment.save()
                # Payment
                payment = PaymentSerializer(data=cleaned_data['payment'])
                payment.is_valid(raise_exception=True)
                payment.save()
                # Job
                job = cleaned_data['order']
                job['poster'] = request.user.id
                job['product'] = product.data['id']
                job['payment'] = payment.data['id']
                job['shipment'] = shipment.data['id']
                #
                job_instance = JobSerializer(data=job)
                job_instance.is_valid(raise_exception=True)
                job_instance.save()
                job_data = get_jobs_data({'id': job_instance.data['id']})
                return Response(job_data[0], status=status.HTTP_201_CREATED)

        except Exception as e:
            print(e)
            return Response(e, status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['get'], detail=False)
    def jobs(self, request):
        fromDate = request.query_params.get('fromDate')
        toDate = request.query_params.get('toDate')
        jobs_query = None
        if fromDate and toDate:
            fD = datetime.strptime(fromDate, '%d/%m/%Y')
            tD = datetime.strptime(toDate, '%d/%m/%Y')
            jobs_query = Job.objects.filter(is_active=True, shipment_job__shipping_date__gte=fD,
                                            shipment_job__expected_delivery_date__lte=tD).prefetch_related(
                'shipment_job', 'product_job')
        else:
            jobs_query = Job.objects.filter(is_active=True).prefetch_related('shipment_job', 'product_job')
        jobs_data = JobSerializer(jobs_query, many=True).data

        for i in range(len(jobs_data)):
            shipment = [shipment for shipment in
                        jobs_query[i].shipment_job.all().select_related('pick_up', 'delivery_address')]
            jobs_data[i]['shipment'] = ShipmentSerializer(shipment[0]).data
            products = [products for products in jobs_query[i].product_job.all()]
            jobs_data[i]['products'] = ProductSerializer(products, many=True).data
        return HttpResponse(json.dumps(jobs_data), status=status.HTTP_200_OK)

    @action(methods=['get'], detail=False, url_path='my-jobs')
    def my_jobs(self, request):
        job_status = request.query_params.get('status')
        if job_status:
            jobs_data = get_jobs_data({'poster_id': request.user.id, 'status': job_status})
            return Response(jobs_data, status=status.HTTP_200_OK)
        else:
            return Response({'order status is required!!!'}, status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['post'], detail=False)
    def accept(self, request):
        job_id = request.data.get('job')
        shipper_id = request.data.get('shipper')
        user = request.user
        if job_id and shipper_id:
            try:
                job = Job.objects.get(pk=int(job_id), poster_id=user.id)
                shipper = Shipper.objects.get(pk=int(shipper_id))
                job.winner = shipper
                job.save()
                return Response(status=status.HTTP_200_OK)
            except Job.DoesNotExist:
                return Response({'Poster not found'}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['get'], detail=True, url_path='list-shipper')
    def list_shipper(self, request, pk):
        user = request.user
        job = Job.objects.filter(poster_id=user.id, id=pk).prefetch_related('auction_job')
        if job:
            shipper = [auction.shipper for auction in job[0].auction_job.select_related('shipper').all()]
            return Response(ShipperSerializer(shipper, many=True).data, status=status.HTTP_200_OK)
        else:
            return Response([], status=status.HTTP_404_NOT_FOUND)


class ShipperJobViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Job.objects.all()
    serializer_class = JobSerializer

    def get_permissions(self):
        if self.action in ['find_job','job']:
            self.permission_classes = [IsShipper]
        return super(ShipperJobViewSet, self).get_permissions()

    @action(methods=['get'], detail=False, url_path='find-job')
    def find_job(self, request):
        job_status = request.query_params.get('status')
        shipper = request.user
        if job_status:
            jobs_query = Job.objects.filter(status=job_status).select_related('shipment', 'shipment__pick_up', 'shipment__delivery_address',
                                                    'product', 'product__category', 'payment', 'payment__method','vehicle').prefetch_related('auction_job')
            jobs_data = JobSerializer(jobs_query, many=True).data
            data = []
            for i in range(len(jobs_data)):
                # Check joined this job or not
                is_join = [action for a in jobs_query[i].auction_job.all() if a.shipper.id == shipper.id]
                if len(is_join) == 0:
                    # shipment
                    jobs_data[i]['shipment'] = ShipmentSerializer(jobs_query[i].shipment).data
                    jobs_data[i]['shipment']['pick_up'] = AddressSerializer(jobs_query[i].shipment.pick_up).data
                    jobs_data[i]['shipment']['delivery_address'] = AddressSerializer(
                        jobs_query[i].shipment.delivery_address).data
                    # Product
                    jobs_data[i]['product'] = ProductSerializer(jobs_query[i].product).data
                    jobs_data[i]['product']['category'] = ProductCategorySerializer(jobs_query[i].product.category).data
                    # Payment
                    jobs_data[i]['payment'] = PaymentSerializer(jobs_query[i].payment).data
                    jobs_data[i]['payment']['method'] = PaymentMethodSerializer(jobs_query[i].payment.method).data
                    # Vehicle
                    jobs_data[i]['vehicle'] = VehicleSerializer(jobs_query[i].vehicle).data
                    data.append(jobs_data[i])
            return Response(data, status=status.HTTP_200_OK)
        else:
            return Response({'order status is required!!!'}, status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['get','post'], detail=True, url_path='job')
    def job(self, request, pk=None):
        if request.method == "GET":
            jobs_data = get_jobs_data({'id': pk})
            shipper_count = Auction.objects.filter(job__id=pk).count()
            return Response({'job': jobs_data[0], 'joined_shipper': shipper_count}, status=status.HTTP_200_OK)
        elif request.method == "POST":
            job = Job.objects.get(pk=pk)
            if job.status == Job.Status.FINDING_SHIPPER:
                try:
                    Auction.objects.create(job_id=pk,shipper_id=request.user.id)
                    return Response({"join successfully"}, status=status.HTTP_201_CREATED)
                except IntegrityError:
                    return Response({"you're joined this job before"}, status=status.HTTP_400_BAD_REQUEST)
            else:
                return Response({"job is not in finding shipper state"}, status=status.HTTP_404_NOT_FOUND)



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
