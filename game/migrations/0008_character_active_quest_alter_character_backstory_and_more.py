# Generated by Django 4.2 on 2023-04-20 11:21

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ("game", "0007_event_active_event_end_event_start"),
    ]

    operations = [
        migrations.AddField(
            model_name="character",
            name="active_quest",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="characters",
                to="game.quest",
            ),
        ),
        migrations.AlterField(
            model_name="character",
            name="backstory",
            field=models.CharField(blank=True, max_length=1000, null=True),
        ),
        migrations.AlterField(
            model_name="character",
            name="current_objective",
            field=models.CharField(blank=True, max_length=1000, null=True),
        ),
        migrations.AlterField(
            model_name="character",
            name="location",
            field=models.ForeignKey(
                default=1,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="characters",
                to="game.location",
            ),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name="character",
            name="relationships",
            field=models.ManyToManyField(
                blank=True,
                null=True,
                related_name="related_to",
                through="game.Relationship",
                to="game.character",
            ),
        ),
        migrations.AlterField(
            model_name="fact",
            name="fact",
            field=models.CharField(max_length=255),
        ),
    ]
