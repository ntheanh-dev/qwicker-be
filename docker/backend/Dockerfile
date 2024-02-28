FROM python:3.11

LABEL maintainer="anhthenguyen.work@gmail.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./deliveryapp /deliveryapp

WORKDIR /deliveryapp

EXPOSE 8000


RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /requirements.txt
RUN mkdir -p /vol/web/static && mkdir -p /vol/web/media
RUN chown -R deliveryapp:deliveryapp /vol && chmod -R 775 /vol

# COPY . .

CMD ["sh", "-c", "python manage.py collectstatic --no-input;python manage.py makemigrations;  python manage.py migrate; gunicorn deliveryapp.wsgi -b 0.0.0.0:8000"]
