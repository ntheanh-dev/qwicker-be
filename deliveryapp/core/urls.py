from django.contrib import admin
from django.urls import path, re_path, include
from rest_framework import routers
from . import views

r = routers.DefaultRouter()

r.register('user', views.UserViewSet)
r.register('role', views.RoleViewSet)
r.register('shipper', views.ShipperViewSet)
r.register('product', views.ProductViewSet)
r.register('job', views.JobViewSet)
r.register('job_type', views.JobTypeViewSet)
r.register('photo', views.PhotoViewSet)
r.register('shipment', views.ShipmentViewSet)
r.register('address', views.AddressViewSet)

urlpatterns = [
    path('', include(r.urls))
]
