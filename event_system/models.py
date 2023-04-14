from tortoise import fields, models

from event_system.config import EVENT_TYPES
from npc.models import Character


class Event(models.Model):
    event_type = fields.CharField(max_length=50, CHOICES=list(EVENT_TYPES.keys()))
    source_character = fields.ForeignKeyField(
        "npc.Character", related_name="events_as_source", null=True, default=None
    )
    target_character = fields.ForeignKeyField(
        "npc.Character", related_name="events_as_target", null=True, default=None
    )
    description = fields.CharField(max_length=1000, null=True, default=None)

    # def get_description(self):
    #     if self.target_character:
    #         return (
    #             f"{self.source_character} {self.description} {self.target_character}."
    #         )


class EventType:
    """
    This class is used to define the types of events that can occur in the game.
    """

    def __init__(self, type_name, text_name, preposition: str = None):
        """
        :param type_name: This is the name of the event type.
        It is used for internal reference.
        :param text_name: This is the name of the event type.
        It is used for printing to the screen & prompts.
        :param preposition: This is the preposition that is used to
        add a preposition to the event output text.

        Example output: "Character_name1 stole from Character_name2."
        """
        self.type_name = type_name  # used for internal reference
        self.text_name = text_name  # used for printing to the screen & prompts

        # preposition is used to add a preposition to the event output text
        # for example, if the event text_name is "stole" then the preposition is "from"
        if preposition is not None:
            self.preposition = preposition
        else:
            self.preposition = ""

    def __str__(self):
        return self.type_name

    def get_text(self):
        return self.text_name + " " + self.preposition


class EventManager:
    """
    This class is used to define the types of events that can occur in the game.
    """

    async def add_event(self, event: Event):
        await event.save()

    async def get_events(self):
        return await Event.all().prefetch_related(
            "source_character", "target_character"
        )

    async def get_event(self, index: int):
        return (
            await Event.filter(id=index)
            .first()
            .prefetch_related("source_character", "target_character")
        )

    async def get_last_event(self):
        return (
            await Event.all()
            .order_by("-id")
            .first()
            .prefetch_related("source_character", "target_character")
        )

    async def get_events_by_type(self, event_type: str):
        return (
            await Event.filter(event_type=event_type)
            .all()
            .prefetch_related("source_character", "target_character")
        )

    async def get_events_by_character_source(self, character: Character):
        return (
            await Event.filter(source_character=character)
            .all()
            .prefetch_related("source_character", "target_character")
        )

    async def get_events_by_character_target(self, character: Character):
        return (
            await Event.filter(target_character=character)
            .all()
            .prefetch_related("source_character", "target_character")
        )
