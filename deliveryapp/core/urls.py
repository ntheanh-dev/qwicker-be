from django.contrib import admin
from django.urls import path, re_path, include
from rest_framework import routers
from . import views

r = routers.DefaultRouter()

r.register('users', views.UserViewSet)
r.register('role', views.RoleViewSet)
r.register('shippers', views.ShipperViewSet)
r.register('vehicles', views.VehicleViewSet)
r.register('shipper/vehicle', views.VehicleShipperViewSet)
r.register('products', views.ProductViewSet)
r.register('product-categories', views.ProductCategoryViewSet)
r.register('jobs', views.JobViewSet)
r.register('shipment', views.ShipmentViewSet)
r.register('address', views.AddressViewSet)

urlpatterns = [
    path('', include(r.urls))
]
