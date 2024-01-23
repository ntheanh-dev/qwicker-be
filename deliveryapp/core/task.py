from celery import shared_task
from django.core.mail import send_mail, EmailMultiAlternatives
from django.conf import settings
from django.template.loader import render_to_string
from django.utils.html import strip_tags


# @shared_task(bind=True)
def send_mail_func(receiver, otp, first_name):
    template_name = "core/verify_email.html"
    html_message = render_to_string(template_name, {'otp': otp, 'first_name': first_name})
    text_content = strip_tags(html_message)

    message = EmailMultiAlternatives(
        subject="Qwicker",
        body=text_content,
        from_email=settings.EMAIL_HOST_USER,
        to=[receiver]
    )
    message.send()
    return None
