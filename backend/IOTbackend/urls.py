"""
URL configuration for IOTbackend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from handler.views import ping
from handler import urls as api_urls

urlpatterns = [
    path('admin/', admin.site.urls),
    path('ping/', ping), # 用于测试服务器是否正常运行
    path('api/', include(api_urls)), # 为了方便，将所有的 API 都放在 /api/ 下
]
