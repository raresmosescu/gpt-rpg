"""
The world model is the top level model for the game. It contains all the
information about the game world like the characters, the locations, the items,
the quests, the events, and so on. It is the model that is saved to the
database and loaded from the database.

The world model is the model that is used to generate the context for the
GPT-3.5 API. The context is the information that the GPT-3.5 API needs to
accurately generate a response that is not spit out gibberish.
"""

from django.db import models

from game.models.character import Character


# locations are the places where the characters can be
class Location(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=1000, null=True)

    def __str__(self):
        return self.name


# items are the things that the characters can interact with
class Item(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=1000, null=True)

    def __str__(self):
        return self.name


# quests are the things that the characters can do
class Quest(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=1000, null=True)

    def __str__(self):
        return self.name


# events are the things that happen in the world
class Event(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=1000, null=True)
    start = models.DateTimeField(auto_now_add=True)
    end = models.DateTimeField(null=True)
    active = models.BooleanField(default=False)

    def __str__(self):
        return self.name


# factions are the groups that the characters can belong to
class Faction(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=1000, null=True)

    def __str__(self):
        return self.name


# storylines are the overarching plots of the game
class Storyline(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=1000, null=True)

    def __str__(self):
        return self.name


# habits are the things that the characters do regularly
class Habit(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=1000, null=True)

    def __str__(self):
        return self.name


# traditions are the things that factions do regularly
class Tradition(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=1000, null=True)

    def __str__(self):
        return self.name
