from rest_framework.serializers import ModelSerializer, SerializerMethodField, CharField
from .models import *
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
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username', 'password', 'email', 'cmnd']
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


class VehicleSerializer(ModelSerializer):
    class Meta:
        model = Vehicle
        fields = '__all__'


class VehicleShipperSerializer(ModelSerializer):
    class Meta:
        model = VehicleShipper
        fields = '__all__'


class JobSerializer(ModelSerializer):
    class Meta:
        model = Job
        fields = '__all__'


class ProductSerializer(ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'


class ProductCategorySerializer(ModelSerializer):
    class Meta:
        model = ProductCategory
        fields = '__all__'


class AddressSerializer(ModelSerializer):
    class Meta:
        model = Address
        fields = '__all__'


class ShipmentSerializer(ModelSerializer):
    delivery_address = AddressSerializer()
    pick_up = AddressSerializer()

    class Meta:
        model = Shipment
        fields = '__all__'


class AuctionSerializer(ModelSerializer):
    shipper = ShipperSerializer()

    class Meta:
        model = Auction
        fields = '__all__'
