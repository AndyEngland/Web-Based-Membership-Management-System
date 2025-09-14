from django.contrib import admin
from django.urls import path, include

urlpatterns = [
	path('admin/', admin.site.urls),
	# Include the members app URLs if present. If `members.urls` does not exist,
	# this will be ignored by Django at import time when you add the module later.
]

try:
	# Import members.urls only if it exists to avoid import errors / circular imports
	import importlib
	importlib.import_module('members.urls')
	urlpatterns.append(path('', include('members.urls')))
except ModuleNotFoundError:
	# members.urls not present — continue with admin only
	pass

