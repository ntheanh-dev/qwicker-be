from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import AbstractUser
from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from cloudinary.models import CloudinaryField


class BaseModel(models.Model):
    updated_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

    def create_superuser(self, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('role', 1)
        return self.create_user(**extra_fields)


class User(AbstractUser, BaseModel):
    role = models.ForeignKey('Role', related_name="user", on_delete=models.CASCADE, default=1)
    avatar = models.ImageField(upload_to="users/%Y/%m", null=True)

    def __str__(self):
        return self.get_full_name()


class Role(models.Model):
    name = models.CharField(max_length=20)

    def __str__(self):
        return self.name


class Shipper(User):
    cmnd = models.CharField(max_length=12)


class Product(BaseModel):
    job = models.ForeignKey('Job', related_name='product_job', on_delete=models.CASCADE)
    length = models.IntegerField(null=False)
    width = models.IntegerField(null=False)
    height = models.IntegerField(null=False)
    weight = models.IntegerField(null=False)
    quantity = models.IntegerField(null=False)


class Job(BaseModel):
    type = models.ForeignKey('JobType', related_name='job_type', on_delete=models.CASCADE)
    description = models.CharField(max_length=255)
    # null = True when develop
    poster = models.ForeignKey(User, related_name='job_poster', on_delete=models.CASCADE, null=True)
    winner = models.ForeignKey(Shipper, related_name='job_winner', on_delete=models.CASCADE, null=True)
    image = models.CharField(max_length=255)


class JobType(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


class Auction(models.Model):
    job = models.ForeignKey(Job, related_name='auction_job', on_delete=models.CASCADE)
    shipper = models.ForeignKey(Shipper, related_name='auction_shipper', on_delete=models.CASCADE)
    time_joined = models.DateTimeField(auto_now=True)
    comment = models.CharField(max_length=255)
    start_date = models.DateTimeField()
    close_date = models.DateTimeField()
    # maybe add cost filed used for auctioning


class Feedback(models.Model):
    created_at = models.DateTimeField(auto_now=True)
    user = models.ForeignKey(User, related_name='feedback_user', on_delete=models.CASCADE)
    shipper = models.ForeignKey(Shipper, related_name='feedback_shipper', on_delete=models.CASCADE)
    satisfaction_rating = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(5)])
    shipper_cooperation = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(5)])
    overall_rating = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(5)])


class Shipment(models.Model):
    job = models.ForeignKey(Job, related_name='shipment_job', on_delete=models.CASCADE)
    pick_up = models.ForeignKey('Address', related_name='shipment_pickup', on_delete=models.CASCADE)
    delivery_address = models.ForeignKey('Address', related_name='shipment_delivery_address', on_delete=models.CASCADE)
    ready_on = models.DateTimeField(null=True)
    collect_on = models.DateTimeField(null=True)
    delivered_on = models.DateTimeField(null=True)
    cost = models.DecimalField(max_digits=6, decimal_places=2)


class Address(models.Model):
    contact = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=15)
    country = models.CharField(max_length=50)
    city = models.CharField(max_length=50)
    street = models.CharField(max_length=50)
    home_number = models.CharField(max_length=10)


class Payment(BaseModel):
    method = models.ForeignKey('PaymentMethod', on_delete=models.CASCADE)
    job = models.ForeignKey(Job, related_name='payment_job', on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=6, decimal_places=2)


class PaymentMethod(models.Model):
    name = models.CharField(max_length=20)


class Photo(models.Model):
    title = models.CharField(max_length=100, null=True)
    image = CloudinaryField('image')
