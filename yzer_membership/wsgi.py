import os
from django.core.wsgi import get_wsgi_application

# Set default settings module for 'django' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'yzer_membership.settings')

# The WSGI application callable that gunicorn expects to find.
application = get_wsgi_application()
