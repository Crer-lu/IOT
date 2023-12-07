# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import json
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
from handler.models import User, Device
from handler.jwt_token import verify_jwt_token

@require_http_methods(["POST"])
def add(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    dict = json.loads(request.body)
    if verify_jwt_token(dict['userid'], token.split(' ')[1]):
        try:
            usr = User.objects.get(id=dict['userid'])
            device = Device.objects.create(name=dict['name'], description=dict['description'], kind=dict['kind'],user=usr)
            return JsonResponse({'status': 200, 'message': '添加设备成功', 'data':{'deviceid': device.id}})
        except Exception as e:
            print(e.__str__())
            return JsonResponse({'status': 400, 'message': '添加设备失败'})
    else:
        return JsonResponse({'status': 400, 'message': 'token验证失败'})
    
@require_http_methods(["POST"])
def modify(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    dict = json.loads(request.body)
    if verify_jwt_token(dict['userid'], token.split(' ')[1]):
        try:
            device = Device.objects.get(id=dict['deviceid'])
            device.name = dict['name']
            device.description = dict['description']
            device.kind = dict['kind']
            device.save()
            return JsonResponse({'status': 200, 'message': '修改设备成功'})
        except Exception as e:
            print(e.__str__())
            return JsonResponse({'status': 400, 'message': '修改设备失败'})
    else:
        return JsonResponse({'status': 400, 'message': 'token验证失败'})

@require_http_methods(["POST"])
def delete(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    dict = json.loads(request.body)
    if verify_jwt_token(dict['userid'], token.split(' ')[1]):
        try:
            device = Device.objects.get(id=dict['deviceid'])
            device.delete()
            return JsonResponse({'status': 200, 'message': '删除设备成功'})
        except Exception as e:
            print(e.__str__())
            return JsonResponse({'status': 400, 'message': '删除设备失败'})
    else:
        return JsonResponse({'status': 400, 'message': 'token验证失败'})

# single device info
@require_http_methods(["GET"])  
def query_info(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    uid = request.GET.get('userid')
    if verify_jwt_token(uid, token.split(' ')[1]):
        try:
            device = Device.objects.get(id=request.GET.get('deviceid'))
            return JsonResponse({'status': 200, 'message': '查询设备成功', 'data':{'deviceid':device.id, 'name': device.name, 'status': device.status ,'description': device.description, 'last_active_time':device.last_activate_time, 'kind': device.kind, 'userid': device.user.id}})
        except Exception as e:
            print(e.__str__())
            return JsonResponse({'status': 400, 'message': '查询设备失败'})

# devices list owned by single user
@require_http_methods(["GET"])     
def query_list(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    uid = request.GET.get('userid')
    try:
        usr = User.objects.get(id=uid)
    except Exception as e:
        print(e.__str__())
        return JsonResponse({'status': 400, 'message': '用户不存在'})
    if verify_jwt_token(uid, token.split(' ')[1]):
        try:
            devices = Device.objects.filter(user=usr)
            data = []
            for device in devices:
                data.append({'deviceid':device.id, 'name': device.name, 'status': device.status, 'description': device.description, 'last_active_time':device.last_activate_time, 'kind': device.kind, 'userid': device.user.id})
            return JsonResponse({'status': 200, 'message': '查询设备列表成功', 'data': data})
        except Exception as e:
            print(e.__str__())
            return JsonResponse({'status': 400, 'message': '查询设备列表失败'})
        