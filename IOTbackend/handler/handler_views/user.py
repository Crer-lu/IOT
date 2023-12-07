# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import json
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
from handler.models import User
from handler.jwt_token import generate_jwt_token, verify_jwt_token


# Create your views here.
@require_http_methods(["POST"])
def register(request):
    dict = json.loads(request.body)
    try:
        user = User.objects.create(name=dict['name'], password=dict['password'], email=dict['email'])
        return JsonResponse({'status': 200, 'message': '注册成功'})
    except Exception as e:
        print(e.__str__())
        return JsonResponse({'status': 400, 'message': '邮箱已被使用'})
    
@require_http_methods(["POST"])
def login(request):
    dict = json.loads(request.body)
    username=dict['name']
    password=dict['password']

    try:
        user = User.objects.get(name=username)
    except Exception as e:
        print(e.__str__())
        return JsonResponse({'status': 400, 'message': '用户不存在'})
    else:
        if user.password != password:
            return JsonResponse({'status': 400, 'message': '密码错误'})
        else:
            token = generate_jwt_token(user.id)
            return JsonResponse({'status': 200, 'message': '登录成功', 'data': {'userid':user.id, 'token': token.decode()}})

@require_http_methods(["POST"])
def logout(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    dict = json.loads(request.body)
    userid = dict['userid']
    if verify_jwt_token(userid, token.split(' ')[1]):
        return JsonResponse({'status': 200, 'message': '登出成功'})
    else:
        return JsonResponse({'status': 400, 'message': '登出失败'})

@require_http_methods(["POST"])  
def delete(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    dict = json.loads(request.body)
    userid = dict['userid']
    if verify_jwt_token(userid, token.split(' ')[1]):
        user = User.objects.get(id=dict['userid'])
        user.delete()
        return JsonResponse({'status': 200, 'message': '删除成功'})
    else:
        return JsonResponse({'status': 400, 'message': 'token失效'})

# used to modify password
@require_http_methods(["POST"])
def modify_passwd(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    dict = json.loads(request.body)
    userid = dict['userid']
    if verify_jwt_token(userid, token.split(' ')[1]):
        user = User.objects.get(id=dict['userid'])
        if(user.password != dict['oldpasswd']):
            return JsonResponse({'status': 400, 'message': '原密码错误'})
        user.password = dict['newpasswd']
        user.save()
        return JsonResponse({'status': 200, 'message': '修改成功'})
    else:
        return JsonResponse({'status': 400, 'message': 'token失效'})

# can be used to modify email and name
@require_http_methods(["POST"])
def modify_info(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    dict = json.loads(request.body)
    userid = dict['userid']
    if verify_jwt_token(userid, token.split(' ')[1]):
        user = User.objects.get(id=dict['userid'])
        user.name = dict['name']
        user.email = dict['email']
        user.save()
        return JsonResponse({'status': 200, 'message': '修改成功'}) 
    else:
        return JsonResponse({'status': 400, 'message': 'token失效'})

@require_http_methods(["GET"])
def query_info(request):
    token = request.headers.get('Authorization')
    if token is None:
        return JsonResponse({'status': 400, 'message': 'token为空'})
    userid = request.GET.get('userid')
    if verify_jwt_token(userid, token.split(' ')[1]):
        user = User.objects.get(id=userid)
        return JsonResponse({'status': 200, 'message': '查询成功', 'data': {'id':user.id, 'name': user.name, 'email': user.email}})
    else:
        return JsonResponse({'status': 400, 'message': 'token失效'})