"""
Create a new game.
"""
from event_system.models import Event
from game.user_interface import UserInterface
from npc import models as npc_models
from event_system import models as event_models
from npc.config import RELATIONSHIP_TYPES, TRAITS
from event_system.config import EVENT_TYPES


async def set_up_game():
    """
    Create a new game.
    """
    # create event manager

    event_manager = event_models.EventManager()

    # get or create characters
    character1 = await npc_models.Character.get_or_create(name="John")
    character2 = await npc_models.Character.get_or_create(name="Jane")

    # await character2.generate_random_traits(add_traits=True)
    # await character1.generate_random_traits(add_traits=True)

    # await npc_models.Relationship.create(
    #     char1=character1,
    #     char2=character2,
    #     type="friend",
    # )

    await Event.create(event_type="start_game")
