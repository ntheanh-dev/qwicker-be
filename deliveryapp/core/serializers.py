from rest_framework.serializers import ModelSerializer, SerializerMethodField, CharField
from .models import *


class BasicUserSerializer(ModelSerializer):
    class Meta:
        model = BasicUser
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username', 'password', 'email', 'role']
        extra_kwargs = {
            'password': {'write_only': True},
            'role': {'read_only': True},
        }

    def to_representation(self, instance):
        # Customize the representation of the serialized data here
        representation = super().to_representation(instance)
        representation['avatar'] = instance.avatar.url
        return representation

    def create(self, validated_data):
        data = validated_data.copy()
        u = User(**data)
        u.role = User.Roles.BASIC_USER
        u.set_password(u.password)

        u.save()

        return u


class ShipperSerializer(ModelSerializer):
    class Meta:
        model = Shipper
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username', 'password', 'email', 'role']
        extra_kwargs = {
            'password': {'write_only': True},
            'role': {'read_only': True},
        }

    def to_representation(self, instance):

        # Customize the representation of the serialized data here
        representation = super().to_representation(instance)
        representation['avatar'] = instance.avatar.url
        try:
            representation['more'] = ShipperMoreSerializer(instance=instance.more).data
        except AttributeError:
            pass

        return representation

    def create(self, validated_data):
        data = validated_data.copy()
        u = User(**data)
        u.role = User.Roles.SHIPPER
        u.set_password(u.password)
        u.save()

        return u


class ShipperMoreSerializer(ModelSerializer):
    class Meta:
        model = ShipperMore
        fields = ['cmnd', 'vehicle', 'vehicle_number']

    def to_representation(self, instance):
        # Customize the representation of the serialized data here
        representation = super().to_representation(instance)
        representation['cmnd'] = instance.cmnd.url
        return representation


class VehicleSerializer(ModelSerializer):
    class Meta:
        model = Vehicle
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
