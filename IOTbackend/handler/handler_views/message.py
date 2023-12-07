# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import json
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
from handler.models import User, Device, Message
from handler.jwt_token import verify_jwt_token

@require_http_methods(["POST"])
def create(request):
    dict = json.loads(request.body)
    try:
        device = Device.objects.get(id=dict['deviceid'])
        message = Message.objects.create(device=device, info=dict['info'], latitude=dict['latitude'], longitude=dict['longitude'], value=dict['value'])
        return JsonResponse({'status': 200, 'message': '添加消息成功', 'data':{'messageid': message.id}})
    except Exception as e:
        print(e.__str__())
        return JsonResponse({'status': 400, 'message': '添加消息失败'})


@require_http_methods(["GET"])
def path(request):
    did = request.GET.get('deviceid')
    if did is None:
        return JsonResponse({'status': 400, 'message': 'deviceid为空'})
    try:
        device = Device.objects.get(id=did)
        messages = Message.objects.filter(device=device)
        data = []
        for message in messages:
            data.append({'latitude': message.latitude, 'longitude': message.longitude})
        return JsonResponse({'status': 200, 'message': '查询成功', 'data': data})
    except Exception as e:
        print(e.__str__())
        return JsonResponse({'status': 400, 'message': '查询失败'})
    
@require_http_methods(["GET"])
def info(request):
    did = request.GET.get('deviceid')
    if did is None:
        return JsonResponse({'status': 400, 'message': 'deviceid为空'})
    try:
        device = Device.objects.get(id=did)
        messages = Message.objects.filter(device=device)
        data = []
        for message in messages:
            data.append({'info': message.info})
        return JsonResponse({'status': 200, 'message': '查询成功', 'data': data})
    except Exception as e:
        print(e.__str__())
        return JsonResponse({'status': 400, 'message': '查询失败'})
    
@require_http_methods(["GET"])
def value(request):
    did = request.GET.get('deviceid')
    if did is None:
        return JsonResponse({'status': 400, 'message': 'deviceid为空'})
    try:
        device = Device.objects.get(id=did)
        messages = Message.objects.filter(device)
        data = []
        for message in messages:
            data.append({'value': message.value})
        return JsonResponse({'status': 200, 'message': '查询成功', 'data': data})
    except Exception as e:
        print(e.__str__())
        return JsonResponse({'status': 400, 'message': '查询失败'})

# query all message of devices owned by single user
@require_http_methods(["GET"])
def all(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    uid = request.GET.get('userid')
    if uid is None:
        return JsonResponse({'status': 400, 'message': 'userid为空'})
    if verify_jwt_token(uid, token.split(' ')[1]):
        usr = User.objects.get(id=uid)
        devices = Device.objects.filter(user=usr)
        messages = Message.objects.filter(device__in=devices)
        data = []
        for message in messages:
            data.append({'messageid':message.id, 'deviceid': message.device.id, 'info': message.info, 'latitude': message.latitude, 'longitude': message.longitude, 'time_stamp': message.time_stamp, 'value': message.value})
        return JsonResponse({'status': 200, 'message': '查询成功', 'data': data})
    else:
        return JsonResponse({'status': 400, 'message': 'token验证失败'})