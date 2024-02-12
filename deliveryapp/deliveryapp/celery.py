import os
from django.conf import settings
from celery import Celery

from django.core.mail import send_mail, EmailMultiAlternatives
from django.conf import settings
from django.template.loader import render_to_string
from django.utils.html import strip_tags

# from django.template.loader import render_to_string
# from django.utils.html import strip_tags

# Set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'deliveryapp.settings')

app = Celery('deliveryapp')

app.conf.enable_utc = False
app.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django apps.
app.autodiscover_tasks()


@app.task(ignore_result=True)
def send_otp(receiver, otp, first_name):
    template_name = "email/send_otp_email.html"
    html_message = render_to_string(template_name, {'first_name': first_name,'otp': otp})

    message = EmailMultiAlternatives(
        subject="Mã OTP Xác Thực Cho Tài Khoản Của Bạn",
        from_email=settings.EMAIL_HOST_USER,
        to=[receiver]
    )
    message.attach_alternative(html_message, "text/html")
    message.send()
    return None


@app.task(ignore_result=True)
def send_apologia(receivers,uuid):
    template_name = "email/apologia_email.html"
    html_message = render_to_string(template_name,{'uuid': uuid})

    message = EmailMultiAlternatives(
        subject="Thông Báo Từ Chối Cho Đơn Hàng Vận Chuyển",
        from_email=settings.EMAIL_HOST_USER,
        to=receivers
    )
    message.attach_alternative(html_message,"text/html")
    message.send()
    return None


@app.task(ignore_result=True)
def send_congratulation(receiver,first_name):
    template_name = "email/congratulation_email.html"
    html_message = render_to_string(template_name, {'first_name': first_name})

    message = EmailMultiAlternatives(
        subject="Thông Báo Chọn Làm Shipper Cho Đơn Hàng",
        from_email=settings.EMAIL_HOST_USER,
        to=[receiver]
    )
    message.attach_alternative(html_message,"text/html")
    message.send()
    return None
