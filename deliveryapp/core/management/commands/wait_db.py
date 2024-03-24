import time

from psycopg2 import OperationalError as Psyco2OperationalError

from django.db.utils import OperationalError
from django.core.management.base import BaseCommand
from django.db import connections
from django.core.management.base import BaseCommand
import time

class Command(BaseCommand):
    def handle(self, *args, **options):
        self.stdout.write('Waiting for database...')
        db_up = False
        while not db_up:
            try:
                connections['default'].ensure_connection()
                db_up = True
            except OperationalError:
                self.stdout.write('Database unavailable, waiting 1 second...')
                time.sleep(1)

        self.stdout.write(self.style.SUCCESS('Database available!'))