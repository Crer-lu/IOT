from django.db import models
from django.utils import timezone


# Create your models here.
class User(models.Model):
    # Django automatically adds an auto-incrementing primary key field named 'id' by default.
    # If you want to explicitly define it, you can uncomment the following line:
    id = models.AutoField(primary_key=True)

    name = models.CharField(max_length=128, null=False)
    password = models.CharField(max_length=128, null=False)
    email = models.CharField(max_length=128, null=False, unique=True)

    def __str__(self):
        return self.name
    
    class Meta:
        db_table = 'user'

class Device(models.Model):
    # Django 默认为每个模型添加一个名为 'id' 的自增主键，所以通常不需要显式定义它。
    id = models.AutoField(primary_key=True)

    name = models.CharField(max_length=128, null=False)
    description = models.CharField(max_length=256, null=False)
    user = models.ForeignKey('User', on_delete=models.CASCADE, null=False)
    kind = models.IntegerField(default=0, null=False)
    status = models.BooleanField(default=False, null=False)
    last_activate_time = models.DateTimeField(default=timezone.now, null=False)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'device'

class Message(models.Model):
    # 假设 Device 是一个已存在的模型，device 字段是一个指向 Device 模型的外键
    # 如果实际情况不是这样，请根据您的需要调整这个字段
    device = models.ForeignKey('Device', on_delete=models.CASCADE, null=False)

    # 用于表示警报状态的布尔字段（Django 中没有直接的 int 类型）
    alert = models.BooleanField(default=False)  # 默认为 False，可以表示 0 -> 否

    # 其他字段
    info = models.CharField(max_length=128, blank=True)  # 可以为空字符串
    latitude = models.DecimalField(default=0, max_digits=9, decimal_places=6)  # 假设的精度
    longitude = models.DecimalField(default=0, max_digits=9, decimal_places=6)  # 假设的精度
    time_stamp = models.DateTimeField(default=timezone.now)
    value = models.IntegerField(default=0)

    def __str__(self):
        return self.device.name  # 假设 Device 有一个 name 字段

    class Meta:
        db_table = 'message'  # 自定义的数据库表名