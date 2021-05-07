from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import Group

from .models import User


class BaseUserAdmin(UserAdmin):
    list_display = ['email', 'is_admin', 'is_student', 'is_teacher']
    search_fields = ["email", 'is_admin', 'is_student', 'is_teacher']
    readonly_fields = (
        'date_joined',
        'last_login',
    )
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ['email']


admin.site.unregister(Group)
admin.site.register(User, BaseUserAdmin)
