from rest_framework.serializers import ModelSerializer, SerializerMethodField, DateTimeField
from .models import *
from django.utils import timezone


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
        try:
            representation['avatar'] = instance.avatar.url
        except AttributeError:
            pass
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
        try:
            representation['avatar'] = instance.avatar.url
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


class VehicleSerializer(ModelSerializer):
    class Meta:
        model = Vehicle
        fields = '__all__'

    def to_representation(self, instance):
        # Customize the representation of the serialized data here
        representation = super().to_representation(instance)
        try:
            representation['icon'] = instance.icon.url
        except AttributeError:
            pass
        return representation


class ShipperMoreSerializer(ModelSerializer):
    vehicle = VehicleSerializer()

    class Meta:
        model = ShipperMore
        fields = ['vehicle_number', 'cmnd', 'vehicle']

    def to_representation(self, instance):
        # Customize the representation of the serialized data here
        representation = super().to_representation(instance)
        try:
            representation['cmnd'] = instance.cmnd.url
        except AttributeError:
            pass
        return representation


class ProductCategorySerializer(ModelSerializer):
    class Meta:
        model = ProductCategory
        fields = '__all__'


class ProductSerializer(ModelSerializer):
    category = ProductCategorySerializer(read_only=True)

    class Meta:
        model = Product
        fields = '__all__'

    def to_representation(self, instance):
        # Customize the representation of the serialized data here
        representation = super().to_representation(instance)
        if instance.category:
            representation['image'] = instance.image.url
        return representation


class AddressSerializer(ModelSerializer):
    short_name = SerializerMethodField()
    long_name = SerializerMethodField()

    def get_short_name(self, address):
        return address.get_short_name()

    def get_long_name(self, address):
        return address.get_long_name()

    class Meta:
        model = Address
        fields = ['id', 'contact', 'phone_number', 'city', 'country', 'district', 'street', 'home_number', 'latitude',
                  'longitude', 'short_name', 'long_name']


class ShipmentSerializer(ModelSerializer):
    shipment_date = DateTimeField(format='%Y-%m-%d %H:%M')
    pick_up = AddressSerializer(read_only=True)
    delivery_address = AddressSerializer(read_only=True)

    class Meta:
        model = Shipment
        fields = '__all__'

    def create(self, validated_data):
        data = validated_data.copy()
        s = Shipment(**data)
        if s.type == Shipment.Type.NOW:
            s.shipping_date = timezone.now()
        s.save()
        return s


class AuctionSerializer(ModelSerializer):
    shipper = ShipperSerializer()

    class Meta:
        model = Auction
        fields = '__all__'


class PaymentMethodSerializer(ModelSerializer):
    class Meta:
        model = PaymentMethod
        fields = '__all__'


class PaymentSerializer(ModelSerializer):
    method = PaymentMethodSerializer(read_only=True)

    class Meta:
        model = Payment
        fields = '__all__'


class ShipperWithFeedbackSerializer(ShipperSerializer):
    feedbacks = SerializerMethodField()
    rating = SerializerMethodField()
    def get_feedbacks(self, shipper):
        fb_query = self.context.get('feedback')
        if fb_query:
            fb = FeedbackSerializer(fb_query,many=True)
            return fb.data
        else:
            fb = Feedback.objects.filter(shipper_id=shipper.id)
            return FeedbackSerializer(fb,many=True).data

    def get_rating(self, shipper):
        fb = self.get_feedbacks(shipper)
        s = [s['rating'] for s in fb]
        avg = sum(s)/len(fb)
        return round(avg,2)

    class Meta:
        model = Shipper
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username', 'password', 'email', 'role','rating','feedbacks']


class JobSerializer(ModelSerializer):
    product = ProductSerializer(read_only=True)
    shipment = ShipmentSerializer(read_only=True)
    payment = PaymentSerializer(read_only=True)
    vehicle = VehicleSerializer(read_only=True)

    class Meta:
        model = Job
        fields = '__all__'

    def to_representation(self, instance):
        # Customize the representation of the serialized data here
        representation = super().to_representation(instance)
        try:
            representation['uuid'] = str(instance.uuid.int)[:12]
        except AttributeError:
            pass
        return representation


class JobDetailSerializer(JobSerializer):
    winner = ShipperWithFeedbackSerializer()

    class Meta:
        model = Job
        fields = '__all__'


class FeedbackSerializer(ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'
