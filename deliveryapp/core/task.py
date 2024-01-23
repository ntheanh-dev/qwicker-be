from celery import shared_task
from celery import shared_task
from django.core.mail import send_mail
from django.conf import settings


@shared_task(bind=True)
def send_mail_func( receiver, otp):
    mail_subject = "Thông tin OTP"
    message = "Ban đang thực hiện ký tài khoản online. Nập OTP: 4056 để xác thực gd. Mã"
    send_mail(
        subject=mail_subject,
        message=message,
        from_email=settings.EMAIL_HOST_USER,
        recipient_list=[receiver],
        fail_silently=True,
    )
    return None
