import random

from npc.config import NUM_TRAITS, TRAITS
from npc.models import Character, Trait, Relationship
from tortoise.expressions import Q


async def generate_random_traits(character: Character, add_traits=False):
    """
    :param character:  The character to add the traits to.
    :param add_traits:  Boolean to indicate whether to save the traits to the
                        character or only return them as a list.
    :return:  A list of Trait instances.
    """

    # randomly select traits from the TRAITS dictionary
    # until we reach the desired number of traits
    traits = []
    for i in range(NUM_TRAITS):
        trait_type = random.choice(["positive", "negative", "neutral"])
        trait_name = random.choice(TRAITS[trait_type])
        # print(trait_name)
        trait = Trait(name=trait_name)
        await trait.save()  # Save the new Trait instance
        traits.append(trait)
        if add_traits:
            await character.traits.add(trait)
    return traits


async def get_all_relationships_of_a_character(character: Character):
    # find all relationships where the character is either char1 or char2
    # and return a string of all the relationships
    relationships = []
    for rel in (
        await Relationship.filter(Q(char1=character) | Q(char2=character))
        .prefetch_related("char1", "char2")
        .all()
    ):
        if rel.char1 == character:
            relationships.append(f"{str(rel.type).capitalize()} {rel.char2.name}")
        else:
            relationships.append(f"{str(rel.type).capitalize()} {rel.char1.name}")
    return "\n".join(relationships)
