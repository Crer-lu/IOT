# Generated by Django 4.2.7 on 2023-12-19 01:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('handler', '0002_rename_statas_message_alert'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='phone',
            field=models.DecimalField(decimal_places=0, default=13456789999, max_digits=11),
            preserve_default=False,
        ),
    ]