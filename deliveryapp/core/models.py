from django.contrib.auth.models import AbstractUser
from django.db import models


class BaseModel(models.Model):
    updated_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=False)

    class Meta:
        abstract = True


class User(AbstractUser, BaseModel):
    role = models.ForeignKey('Role', related_name="user", on_delete=models.CASCADE, default=1)
    avatar = models.ImageField()

    def __str__(self):
        return self.get_full_name()


class Shipper(User):
    cmnd = models.CharField(max_length=12)


class Role(models.Model):
    name = models.CharField(max_length=20)

    def __str__(self):
        return self.name
