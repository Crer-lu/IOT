import time

import jwt
from django.conf import settings
from django.contrib.auth import get_user_model
from rest_framework import exceptions
from rest_framework.authentication import BaseAuthentication, get_authorization_header
from handler.models import User

class JWTAuthentication(BaseAuthentication):

    keyword = 'jwt'
    model = None

    # 获取模型，这里使用了django自带的token模型
    def get_model(self):
        if self.model is not None:
            return self.model
        from rest_framework.authtoken.models import Token
        return Token

    """
    A custom token model may be used, but must have the following properties.

    * key -- The string identifying the token
    * user -- The user to which the token belongs
    """

    def authenticate(self, request):
        auth = get_authorization_header(request).split()

        # 判断加密方式是否相同
        if not auth or auth[0].lower() != self.keyword.lower().encode():
            return None

        if len(auth) !=2:
            raise exceptions.AuthenticationFailed("认证异常！")

        # jwt解码
        try:
            jwt_token = auth[1]
            jwt_info = jwt.decode(jwt_token, settings.SECRET_KEY,'HS256')

            # 获取userid
            userid = jwt_info.get("userid")

            # 查询用户是否存在
            try:
                user = User.objects.get(pk=userid)
                return user, jwt_token
            except Exception:
                raise exceptions.AuthenticationFailed("用户不存在")
        except jwt.ExpiredSignatureError:
            raise exceptions.AuthenticationFailed("抱歉，该token已过期！")