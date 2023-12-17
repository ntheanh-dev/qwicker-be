import json
from django.db import transaction
from django.http import HttpResponse
from django.shortcuts import render
from rest_framework import viewsets, generics, permissions, parsers, status
from .models import *
from .serializers import *
from rest_framework.decorators import action
from rest_framework.views import Response
import cloudinary.uploader


# Create your views here.
class UserViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    parser_classes = [parsers.MultiPartParser, ]

    @action(methods=['get', 'put'], detail=False, url_path='current-user')
    def current_user(self, request):
        u = request.user
        if request.method.__eq__('PUT'):
            for k, v in request.data.items():
                setattr(u, k, v)
            u.save()

        return Response(UserSerializer(u, context={'request': request}).data)


class ShipperViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView):
    queryset = Shipper.objects.all()
    serializer_class = ShipperSerializer
    parser_classes = [parsers.MultiPartParser, ]


class RoleViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView):
    queryset = Role.objects.all()
    serializer_class = RoleSerializer


class ProductViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    parser_classes = [parsers.MultiPartParser, ]


class JobViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Job.objects.all()
    serializer_class = JobSerializer

    def get_permissions(self):
        if self.action in ['create']:
            return [permissions.IsAuthenticated()]
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
    def get_all(self, request):
        jobs = Job.objects.filter(is_active=True).prefetch_related('shipment_job','product_job')
        jobs_data = JobSerializer(jobs, many=True).data
        #
        for i in range(len(jobs_data)):
            shipment_queryset = jobs[i].shipment_job.all().first()
            shipment_seria = ShipmentSerializer(shipment_queryset).data
            jobs_data[i]['shippment'] = shipment_seria

            products_queryset = jobs[i].product_job.all()
            products_seria = ProductSerializer(products_queryset,many=True).data
            jobs_data[i]['products'] = products_seria
        return HttpResponse(json.dumps(jobs_data), status=status.HTTP_200_OK)


class JobTypeViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = JobType.objects.all()
    serializer_class = JobTypeSerializer


class ShipmentViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Shipment.objects.all()
    serializer_class = ShipmentSerializer


class AddressViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Address.objects.all()
    serializer_class = AddressSerializer


class PhotoViewSet(viewsets.ViewSet, viewsets.ModelViewSet):
    queryset = Photo.objects.all()
    serializer_class = PhotoSerializer
    parser_classes = [parsers.MultiPartParser, ]
