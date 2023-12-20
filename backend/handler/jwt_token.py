import time
import base64
import jwt
from django.conf import settings

SECRET_KEY='django-insecure-ob14id&8l%ytxb-$itu-si79mt!%_vb-$o(27d(al_a^f8(d#5'

def generate_jwt_token(uid):
    # 设置token的过期时间戳
    # 比如：设置7天过期
    timestamp = int(time.time()) + 60 * 60 * 24 * 7
    payload = {"userid": uid, "exp": timestamp}
    token = jwt.encode(payload=payload, key=SECRET_KEY, algorithm="HS256")
    return token

def verify_jwt_token(uid, token):
    payload = {"userid": int(uid)}
    try:
        _payload = jwt.decode(jwt=token, key=SECRET_KEY, algorithms=['HS256'])
    except jwt.ExpiredSignatureError:
        return False
    except jwt.InvalidTokenError:
        print('invalid token')
        return False
    else:
        # print(_payload)
        exp = int(_payload.pop('exp'))
        if time.time() > exp:
            print('已失效')
            return False
        return payload == _payload # 成功返回True，失败返回False