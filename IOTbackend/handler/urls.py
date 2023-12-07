
from django.urls import path
from .handler_views import user, message, device

urlpatterns = [
    # user url
    path('user/register', user.register),
    path('user/login', user.login),
    path('user/logout', user.logout),
    path('user/delete', user.delete),
    path('user/modify/passwd', user.modify_passwd),
    path('user/modify/info', user.modify_info),
    path('user/query/info', user.query_info),
    # # device url
    path('device/add', device.add),
    path('device/modify', device.modify),
    path('device/delete', device.delete),
    path('device/query/info',device.query_info), 
    path('device/query/list',device.query_list),
    # # message url for displaying device in detail
    path('message/create', message.create),
    path('message/path', message.path),
    path('message/info', message.info),
    path('message/value', message.value),
    path('message/all', message.all),
]
