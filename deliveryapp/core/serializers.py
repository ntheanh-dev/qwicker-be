from rest_framework.serializers import ModelSerializer, SerializerMethodField, CharField
from .models import User, Role, Shipper, Job, JobType, Product, Shipment, Address, Auction, Feedback, \
    Payment, PaymentMethod, Photo
from cloudinary.uploader import upload
from cloudinary.forms import CloudinaryFileField
import random

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username', 'password', 'email']
        extra_kwargs = {
            'password': {'write_only': True},
        }

    def to_representation(self, instance):
        # Customize the representation of the serialized data here
        representation = super().to_representation(instance)
        representation['avatar'] = instance.avatar.url
        return representation


    def create(self, validated_data):
        try:
            data = validated_data.copy()
            u = User(**data)

            user_role = Role.objects.get(name="USER")
            u.role = user_role

            u.set_password(u.password)

            u.save()

            return u
        except Role.DoesNotExist:
            return None


class ShipperSerializer(ModelSerializer):
    class Meta:
        model = Shipper
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username', 'password', 'email','cmnd']
        extra_kwargs = {
            'password': {'write_only': True},
        }

    def to_representation(self, instance):
        # Customize the representation of the serialized data here
        representation = super().to_representation(instance)
        representation['avatar'] = instance.avatar.url
        representation['cmnd'] = instance.cmnd.url
        return representation

    def create(self, validated_data):
        try:
            data = validated_data.copy()
            u = Shipper(**data)
            shipper_role = Role.objects.get(name="SHIPPER")
            u.role = shipper_role

            u.is_active = False

            u.set_password(u.password)
            u.save()
            return u
        except Role.DoesNotExist:
            return None


class RoleSerializer(ModelSerializer):
    class Meta:
        model = Role
        fields = ['id', 'name']


class JobTypeSerializer(ModelSerializer):
    class Meta:
        model = JobType
        fields = ['name']


class JobSerializer(ModelSerializer):
    class Meta:
        model = Job
        fields = ['id', 'description', 'type', 'image', 'is_active', 'poster']


class ProductSerializer(ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'


class PhotoSerializer(ModelSerializer):
    class Meta:
        model = Photo
        fields = '__all__'


class AddressSerializer(ModelSerializer):
    class Meta:
        model = Address
        fields = ['id', 'contact', 'phone_number', 'country', 'city', 'street', 'home_number', ]


class ShipmentSerializer(ModelSerializer):
    delivery_address = AddressSerializer()
    pick_up = AddressSerializer()

    class Meta:
        model = Shipment
        fields = ['job', 'pick_up', 'delivery_address', 'shipping_date', 'expected_delivery_date', 'cost', ]


class AuctionSerializer(ModelSerializer):
    shipper = ShipperSerializer()

    class Meta:
        model = Auction
        fields = '__all__'
