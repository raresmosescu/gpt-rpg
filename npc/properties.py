"""
Properties are a way to store data on an NPC.
"""
import random
from typing import List

from npc.config import NUM_TRAITS, TRAITS
import logging

logger = logging.getLogger(__name__)


class BaseProperty:
    pass


class Trait:
    """
    A trait is a single property of a personality.

    Name should be a valid trait name. Value should be a number between 0 and 1.
    """

    def __init__(self, name):
        # check if the trait is valid
        if self.is_valid():
            self.name = name
        else:
            raise Exception("Invalid trait name")

    def is_valid(self):
        return (
            self.name in TRAITS["positive"]
            or self.name in TRAITS["negative"]
            or self.name in TRAITS["neutral"]
        )


class Personality(BaseProperty):
    """
    A personality is a collection of traits.

    Example output:

    """

    def __init__(self, trait_names: List[str] = None, random_traits: bool = False):
        self.traits = []

        if random_traits is True and trait_names is None:
            self.generate_random_traits()

        if random_traits is True and trait_names is not None:
            raise Exception(
                "You cannot specify specific traits and random traits at the same time."
            )

        if trait_names is not None:
            # check if the traits are valid and add them
            for trait_name in trait_names:
                trait = Trait(trait_name)
                self.traits.append(trait)

    def add_trait(self, trait_name):
        trait = Trait(trait_name)
        if len(self.traits) >= NUM_TRAITS:
            raise Exception("Too many traits")
        self.traits.append(trait)

    def generate_random_traits(self):
        # randomly select traits from the TRAITS dictionary
        # until we reach the desired number of traits
        while len(self.traits) <= NUM_TRAITS:
            trait_type = random.choice(["positive", "negative", "neutral"])
            trait_name = random.choice(TRAITS[trait_type])
            trait = Trait(trait_name)
            self.traits.append(trait)


class Backstory(BaseProperty):
    def __init__(self, text: str = None):
        if text:
            self.text = text
        else:
            self.text = ""


class Goal(BaseProperty):
    def __init__(self, name: str = None):
        if name:
            self.name = name
        else:
            self.name = ""
