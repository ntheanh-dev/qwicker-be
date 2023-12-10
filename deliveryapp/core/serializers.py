from rest_framework.serializers import ModelSerializer, SerializerMethodField, CharField
from .models import User, Role, Shipper
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
        }

    def create(self, validated_data):
        data = validated_data.copy()
        u = User(**data)
        result = upload(data['avatar'])

        u.avatar = result['url']
        u.set_password(u.password)
        u.save()
        return u


class ShipperSerializer(UserSerializer):
    class Meta:
        model = Shipper
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username', 'password', 'email', 'cmnd']
        extra_kwargs = {
            'password': {'write_only': True},
            'avatar': {'write_only': True},
        }


class RoleSerializer(ModelSerializer):
    class Meta:
        model = Role
        fields = ['id', 'name']
