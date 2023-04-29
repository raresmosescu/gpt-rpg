# Generated by Django 4.2 on 2023-04-18 23:43

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ("game", "0003_remove_character_description_and_more"),
        ("interface", "0003_message_timestamp"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="message",
            name="receiver",
        ),
        migrations.AddField(
            model_name="message",
            name="recieve",
            field=models.ForeignKey(
                default=2,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="receiver",
                to="game.character",
            ),
            preserve_default=False,
        ),
    ]
