from django.contrib import admin
from django.urls import path, re_path, include
from rest_framework import routers
from . import views

r = routers.DefaultRouter()

r.register('user', views.UserViewSet)
r.register('role', views.RoleViewSet)
r.register('shipper', views.ShipperViewSet)

urlpatterns = [
    path('', include(r.urls))
]
