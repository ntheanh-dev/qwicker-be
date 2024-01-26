import json
from django.db import transaction
from django.http import HttpResponse
from rest_framework import viewsets, generics, permissions, parsers, status
from .models import *
from .perms import JobOwner
from .serializers import *
from rest_framework.decorators import action
from rest_framework.views import Response
from django.core.cache import cache
import cloudinary.uploader
from datetime import datetime
import random
from .task import send_mail_func


# Create your views here.
class BasicUserViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView):
    queryset = BasicUser.objects.all()
    serializer_class = BasicUserSerializer
    parser_classes = [parsers.MultiPartParser, ]

    @action(methods=['get', 'put'], detail=False, url_path='current-user')
    def current_user(self, request):
        u = request.user
        if request.method.__eq__('PUT'):
            for k, v in request.data.items():
                setattr(u, k, v)
            u.save()

        return Response(BasicUserSerializer(u, context={'request': request}).data)

    @action(methods=['post'], detail=False, url_path='sent-otp')
    def sent_otp(self, request):
        if request.data.get('email') and request.data.get('first_name'):
            otp = random.randint(1000, 9999)
            receiver = request.data.get('email')
            first_name = request.data.get('first_name')
            send_mail_func(receiver, otp, first_name)
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

    @transaction.atomic()
    def create(self, request, *args, **kwargs):
        data = request.data

        basic_account_info = {key: data.getlist(key) if len(data.getlist(key)) > 1 else data[key] for key in data}
        selected_fields = ['cmnd', 'vehicle', 'vehicel_number']
        additional_info = {key: basic_account_info.pop(key) for key in selected_fields}

        s = ShipperSerializer(data=basic_account_info)
        s.is_valid(raise_exception=True)
        s_instance = s.save()

        additional_info['user'] = s_instance.id
        sm = ShipperMoreSerializer(data=additional_info)
        sm.is_valid(raise_exception=True)

        return Response(ShipperSerializer(s_instance).data, status=status.HTTP_201_CREATED)


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
        if self.action in ['create', 'jobs', 'my_jobs', 'post_job']:
            return [permissions.IsAuthenticated()]
        if self.action in ['my_jobs', 'accept']:
            return [JobOwner()]
        return [permissions.AllowAny()]

    @action(methods=['post'], detail=False)
    @transaction.atomic()
    def post_job(self, request):
        try:
            job_data = json.loads(request.data.get('job'))
            upload_result = cloudinary.uploader.upload(request.data.get('image'), folder='job_image')
            job_data['image'] = upload_result['url']

            products_data = json.loads(request.data.get('products'))
            shipment_data = json.loads(request.data.get('shipment'))

            user = request.user
            job_data['poster'] = user.id

            with transaction.atomic():
                job = JobSerializer(data=job_data, )
                job.is_valid(raise_exception=True)
                job_instance = job.save()
                products = []

                with transaction.atomic():
                    for product in products_data:
                        product['job'] = job_instance.id
                        p = ProductSerializer(data=product)
                        p.is_valid(raise_exception=True)
                        p.save()
                        products.append(p.data)

                with transaction.atomic():
                    pick_up_data = shipment_data['pick_up']
                    delivery_address_data = shipment_data['delivery_address']

                    pick_up = AddressSerializer(data=pick_up_data)
                    pick_up.is_valid(raise_exception=True)
                    pick_up.save()

                    delivery_address = AddressSerializer(data=delivery_address_data)
                    delivery_address.is_valid(raise_exception=True)
                    delivery_address.save()

                    shipment_data['delivery_address'] = delivery_address.data['id']
                    shipment_data['pick_up'] = pick_up.data['id']
                    shipment_data['job'] = job.data['id']

                    shipment = ShipmentSerializer(data=shipment_data)
                    shipment.is_valid(raise_exception=True)

                    shipment_responce = {**shipment.data, 'delivery_address': {**delivery_address.data},
                                         'pick_up': {**pick_up.data}}

                responce_data = {
                    'job': {**job.data},
                    'products': products,
                    'shipment': {**shipment_responce}
                }
            return Response(json.dumps(responce_data), status=status.HTTP_201_CREATED)
        except Exception as e:
            print(f"Error in outer function: {e}")
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

    @action(methods=['get'], detail=False)
    def my_jobs(self, request):
        user = request.user
        jobs_query = Job.objects.filter(is_active=True, poster_id=user.id).prefetch_related('shipment_job',
                                                                                            'product_job',
                                                                                            'auction_job')
        jobs_data = JobSerializer(jobs_query, many=True).data
        for i in range(len(jobs_data)):
            shipment = [shipment for shipment in
                        jobs_query[i].shipment_job.all().select_related('pick_up', 'delivery_address')]
            jobs_data[i]['shipment'] = ShipmentSerializer(shipment[0]).data

            products = [products for products in jobs_query[i].product_job.all()]
            jobs_data[i]['products'] = ProductSerializer(products, many=True).data

            auctions = [auction for auction in jobs_query[i].auction_job.all().select_related('shipper')]
            jobs_data[i]['auctions'] = AuctionSerializer(auctions, many=True).data
        return HttpResponse(json.dumps(jobs_data), status=status.HTTP_200_OK)
        # return Response({'data'}, status=status.HTTP_200_OK)

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


class ShipmentViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Shipment.objects.all()
    serializer_class = ShipmentSerializer


class AddressViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Address.objects.all()
    serializer_class = AddressSerializer
