import os
from django.conf import settings
from celery import Celery

from django.core.mail import send_mail, EmailMultiAlternatives
from django.conf import settings
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
def send_mail_func(receiver, otp, first_name):
    # template_name = "core/verify_email.html"
    # html_message = render_to_string(template_name, {'otp': otp, 'first_name': first_name})
    # text_content = strip_tags(html_message)

    # message = EmailMultiAlternatives(
    #     subject="Qwicker",
    #     body=text_content,
    #     from_email=settings.EMAIL_HOST_USER,
    #     to=[receiver]
    # )
    # message.send()
    send_mail(
        subject='Add an eye-catching subject',
        message='Write an amazing message',
        from_email=settings.EMAIL_HOST_USER,
        recipient_list=[receiver]
    )
    return None
