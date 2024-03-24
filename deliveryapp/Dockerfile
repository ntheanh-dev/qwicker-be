# More Datascience frendly gist can be found here: https://gist.github.com/ruddra/870d7a51238ddfa4b50375086c12a4f5
# pull official python alpine image
FROM python:3.11

LABEL maintainer="anhthenguyen.work@gmail.com"

# Set Environment Variable
ENV PYTHONUNBUFFERED 1
ENV C_FORCE_ROOT true

WORKDIR /deliveryapp
COPY requirements.txt  requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

ENV PATH="/py/bin:$PATH"

COPY . .
EXPOSE 8000

CMD ["sh", "-c", "python manage.py wait_db;python manage.py collectstatic --no-input;python manage.py makemigrations;python manage.py migrate;python manage.py runserver 0.0.0.0:8000"]
# CMD ["sh", "-c", "python manage.py wait_db;python manage.py collectstatic --no-input;python manage.py makemigrations;  python manage.py migrate; gunicorn deliveryapp.wsgi -b 127.0.0.1:8000"]