# Generated by Django 4.2 on 2023-04-18 23:44

from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ("interface", "0004_remove_message_receiver_message_recieve"),
    ]

    operations = [
        migrations.RenameField(
            model_name="message",
            old_name="recieve",
            new_name="receiver",
        ),
    ]
