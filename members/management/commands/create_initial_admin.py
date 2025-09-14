import os
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = 'Create an initial superuser from ADMIN_* environment variables (idempotent).'

    def handle(self, *args, **options):
        from django.contrib.auth import get_user_model

        User = get_user_model()

        username = os.environ.get('ADMIN_USERNAME')
        email = os.environ.get('ADMIN_EMAIL')
        password = os.environ.get('ADMIN_PASSWORD')

        if not (username and email and password):
            self.stdout.write('WARNING: ADMIN_USERNAME, ADMIN_EMAIL and ADMIN_PASSWORD must be set in the environment to create an admin. Skipping.')
            return

        user = User.objects.filter(username=username).first()
        if user:
            self.stdout.write(f'NOTICE: superuser {username} already exists; skipping')
            return

        User.objects.create_superuser(username=username, email=email, password=password)
        self.stdout.write(f'Created superuser {username}')
