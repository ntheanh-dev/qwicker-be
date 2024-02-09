from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import AbstractUser
from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from cloudinary.models import CloudinaryField
import uuid


class BaseModel(models.Model):
    updated_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class User(AbstractUser):
    class Roles(models.TextChoices):
        ADMIN = "ADMIN", "Admin"
        BASIC_USER = "BASIC_USER", 'Basic user'
        SHIPPER = 'SHIPPER', 'Shipper'

    created_date = models.DateTimeField(auto_now_add=True, null=True)
    updated_date = models.DateTimeField(auto_now=True, null=True)
    verified = models.BooleanField(default=False)

    role = models.CharField(max_length=50, choices=Roles.choices, default=Roles.ADMIN)
    avatar = CloudinaryField('avatar')

    def __str__(self):
        return f'{self.get_full_name()} - {self.role}'


class BasicUserManager(BaseUserManager):
    def get_queryset(self):
        return super().get_queryset().filter(role=User.Roles.BASIC_USER)


class BasicUser(User):
    objects = BasicUserManager()

    class Meta:
        proxy = True


class ShipperManager(BaseUserManager):
    def get_queryset(self):
        return super().get_queryset().select_related('shippermore').filter(role=User.Roles.SHIPPER)


class ShipperMore(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    cmnd = CloudinaryField('cmnd', null=True, default=None, blank=True)
    vehicle = models.ForeignKey("Vehicle", on_delete=models.CASCADE, null=True)
    vehicle_number = models.CharField(max_length=20, null=True)


class Shipper(User):
    objects = ShipperManager()

    @property
    def more(self):
        return self.shippermore

    class Meta:
        proxy = True


class Vehicle(models.Model):
    name = models.CharField(max_length=100)
    description = models.CharField(max_length=255)
    capacity = models.CharField(max_length=100)
    icon = CloudinaryField(folder='vehicle_icon')

    def __str__(self):
        return self.name


class Product(models.Model):
    # True when user select another product category
    category = models.ForeignKey('ProductCategory', related_name='product_category', on_delete=models.CASCADE,
                                 null=True)
    quantity = models.IntegerField()
    image = CloudinaryField('image', folder='product')
    mass = models.CharField(max_length=100)


class ProductCategory(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


class Job(BaseModel):
    class Status(models.TextChoices):
        FINDING_SHIPPER = 1,
        WAITING_SHIPPER = 2
        WAITING_PAY = 3
        SHIPPING = 4
        DONE = 5
        CANCELED = 6

    status = models.CharField(max_length=50, choices=Status.choices, default=Status.FINDING_SHIPPER)
    uuid = models.UUIDField(default=uuid.uuid4(), editable=False)
    poster = models.ForeignKey(User, null=True, blank=True, related_name='job_poster', on_delete=models.CASCADE)
    vehicle = models.ForeignKey(Vehicle, null=True, blank=True, related_name='job_vehicle', on_delete=models.CASCADE)
    description = models.CharField(max_length=255, null=True)
    product = models.ForeignKey(Product, null=True, blank=True, related_name='job_prd', on_delete=models.CASCADE)
    winner = models.ForeignKey(Shipper, null=True, blank=True, related_name='job_winner', on_delete=models.CASCADE)
    payment = models.ForeignKey('Payment', null=True, blank=True, related_name='job_payment', on_delete=models.CASCADE)
    shipment = models.ForeignKey('Shipment', null=True, blank=True, related_name='job_shipment',
                                 on_delete=models.CASCADE)


class Auction(models.Model):
    job = models.ForeignKey(Job, related_name='auction_job', on_delete=models.CASCADE)
    shipper = models.ForeignKey(Shipper, related_name='auction_shipper', on_delete=models.CASCADE)
    time_joined = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ('job', 'shipper')


class Feedback(models.Model):
    created_at = models.DateTimeField(auto_now=True)
    user = models.ForeignKey(User, related_name='feedback_user', on_delete=models.CASCADE)
    shipper = models.ForeignKey(Shipper, related_name='feedback_shipper', on_delete=models.CASCADE)
    job = models.ForeignKey(Job, related_name='feedback_job', on_delete=models.CASCADE)
    rating = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(5)])
    comment = models.CharField(max_length=255,blank=True)

    class Meta:
        unique_together = ('user', 'job')


class Shipment(models.Model):
    class Type(models.TextChoices):
        NOW = "Now", "NOW"
        LATTER = "Latter", 'LATTER'

    pick_up = models.ForeignKey('Address', null=True, blank=True, related_name='shipment_pickup',
                                on_delete=models.CASCADE)
    delivery_address = models.ForeignKey('Address', null=True, blank=True, related_name='shipment_delivery_address',
                                         on_delete=models.CASCADE)
    type = models.CharField(max_length=10, choices=Type.choices, default=Type.NOW)
    shipment_date = models.DateTimeField()
    cost = models.DecimalField(max_digits=8, decimal_places=0, null=True)  # max 90000.000


class Address(models.Model):
    contact = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=15)
    country = models.CharField(max_length=20)
    city = models.CharField(max_length=50)
    district = models.CharField(max_length=50)
    street = models.CharField(max_length=50, null=True)
    home_number = models.CharField(max_length=10, null=True)
    latitude = models.DecimalField(max_digits=17, decimal_places=15)
    longitude = models.DecimalField(max_digits=17, decimal_places=14)

    def get_long_name(self):
        if self.home_number and self.street:
            return f'{self.home_number} Đ. {self.street}, {self.district}, Thành phố {self.city}, {self.country}'
        else:
            return f'{self.district}, Thành phố {self.city}, {self.country}'

    def get_short_name(self):
        if self.home_number and self.street:
            return f'{self.home_number} Đ. {self.street}'
        else:
            return f'{self.district}'


class Payment(models.Model):
    method = models.ForeignKey('PaymentMethod', null=True, blank=True, related_name='job_pmt', on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=8, decimal_places=0, null=True)
    is_poster_pay = models.BooleanField(default=True)
    payment_date = models.DateTimeField(null=True)


class PaymentMethod(models.Model):
    name = models.CharField(max_length=20)
