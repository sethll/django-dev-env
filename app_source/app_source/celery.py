#!/usr/bin/env python
import os
from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app_source.settings')

app = Celery('app_source')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()
