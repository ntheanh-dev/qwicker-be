from django.shortcuts import render
from rest_framework import viewsets, generics, permissions, parsers, status
from .models import User, Shipper, Role
from .serializers import *
from rest_framework.decorators import action
from rest_framework.views import Response


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


class RoleViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView):
    queryset = Role.objects.all()
    serializer_class = Role
