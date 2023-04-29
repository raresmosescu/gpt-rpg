from django.contrib import admin

# Register your models here.
from interface.models import Message

admin.site.register(Message)
