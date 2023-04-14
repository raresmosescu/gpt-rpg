import random

from tortoise import fields, models
from npc.config import (
    RANDOM_CHARACTER_NAMES,
    RELATIONSHIP_TYPES,
    TRAITS,
    NUM_TRAITS,
    PROMPT_TYPES,
)


class Character(models.Model):
    name = fields.CharField(max_length=100, unique=True)
    traits = fields.ManyToManyField("npc.Trait")
    backstory = fields.CharField(max_length=1000, null=True)
    current_objective = fields.CharField(max_length=1000, null=True)
    relationships = fields.ManyToManyField(
        "npc.Character", through="relationship", related_name="related_to"
    )
    is_player = fields.BooleanField(default=False)


class Relationship(models.Model):
    char1 = fields.ForeignKeyField("npc.Character", related_name="char1_relationships")
    char2 = fields.ForeignKeyField("npc.Character", related_name="char2_relationships")
    type = fields.CharField(max_length=50, choices=RELATIONSHIP_TYPES)

    def __str__(self):
        return f"{self.type} {self.char2.name}"


class Trait(models.Model):
    """
    A trait is a single property of a personality.

    Name should be a valid trait name.
    """

    name = fields.CharField(max_length=100)

    def is_valid(self):
        return (
            self.name in TRAITS["positive"]
            or self.name in TRAITS["negative"]
            or self.name in TRAITS["neutral"]
        )

    @staticmethod
    async def get_all_traits_of_a_character(character: Character):
        return await character.traits.all()


class Backstory(models.Model):
    text = fields.CharField(max_length=1000)

    class Meta:
        db_table = "backstory"


class Goal(models.Model):
    name = fields.CharField(max_length=100)


class Message(models.Model):
    # conversation between two characters or between a character and the player
    # a conversation is a list of messages

    sender = fields.ForeignKeyField("npc.Character", related_name="sender")
    receiver = fields.ForeignKeyField("npc.Character", related_name="receiver")
    role = fields.CharField(max_length=50, choices=PROMPT_TYPES)
    text = fields.TextField()
    timestamp = fields.DatetimeField(auto_now_add=True)
