from rest_framework.serializers import ModelSerializer, SerializerMethodField, CharField
from .models import User, Role, Shipper, Job, JobType, Product, ProductType, Shipment, Address, Auction, Feedback, \
    Payment, PaymentMethod
from cloudinary.uploader import upload


class UserSerializer(ModelSerializer):
    image = SerializerMethodField(source='avatar')

    def get_image(selfs, user):
        if user.avatar:
            request = selfs.context.get('request')
            if request:
                return request.build_absolute_uri(user.avatar)
            return '/static/users%s' % user.avatar.name

    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username', 'password', 'email', 'image']
        extra_kwargs = {
            'password': {'write_only': True},
            'date_joined': {'read_only': True}
        }

    def create(self, validated_data):
        role = type(self).__name__
        try:
            data = validated_data.copy()
            u = User(**data)

            user_role = Role.objects.get(name="USER")
            u.role = user_role

            result = upload(data['avatar'])
            u.avatar = result['url']

            u.set_password(u.password)

            u.save()
            return u
        except Role.DoesNotExist:
            return None


class ShipperSerializer(UserSerializer):
    class Meta:
        model = Shipper
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username', 'password', 'email', 'cmnd']
        extra_kwargs = {
            'password': {'write_only': True},
            'avatar': {'write_only': True},
        }

    def create(self, validated_data):
        try:
            data = validated_data.copy()
            u = Shipper(**data)
            shipper_role = Role.objects.get(name="SHIPPER")
            u.role = shipper_role

            u.is_active = False

            result = upload(data['avatar'])
            u.avatar = result['url']

            u.set_password(u.password)

            u.save()
            return u
        except Role.DoesNotExist:
            return None


class RoleSerializer(ModelSerializer):
    class Meta:
        model = Role
        fields = ['id', 'name']


class JobSerializer(ModelSerializer):
    class Meta:
        model = Job
        fields = '__all__'


class JobTypeSerializer(ModelSerializer):
    class Meta:
        model = JobType
        fields = ['name']


class ProductSerializer(ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'


class ProductTypeSerializer(ModelSerializer):
    class Meta:
        model = ProductType
        fields = '__all__'
