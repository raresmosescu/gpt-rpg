from typing import List

from game.models import (
    Location,
    Item,
    Quest,
    Event,
    Faction,
    Storyline,
    Habit,
    Tradition,
    Character,
    Relationship,
    Trait,
    Fact,
)
from django.db.models import Q
from django.core.exceptions import FieldDoesNotExist

# import queryset to create an empty queryset
from interface.model_filters import (
    NameAndDescriptionFilter,
    CharacterFilter,
    RelationshipFilter,
)


class GameData:
    def __init__(self):
        self.models = {
            "location": Location,
            "item": Item,
            "quest": Quest,
            "event": Event,
            "faction": Faction,
            "storyline": Storyline,
            "habit": Habit,
            "tradition": Tradition,
            "relationship": Relationship,
            "character": Character,
        }

        self.filters = {
            "location": NameAndDescriptionFilter,
            "item": NameAndDescriptionFilter,
            "quest": NameAndDescriptionFilter,
            "event": NameAndDescriptionFilter,
            "faction": NameAndDescriptionFilter,
            "storyline": NameAndDescriptionFilter,
            "habit": NameAndDescriptionFilter,
            "tradition": NameAndDescriptionFilter,
            "relationship": RelationshipFilter,
            "character": CharacterFilter,
        }

    def get_all_data_from_keywords(self, keywords: List[str]):
        # get all the data from the game data that matches the keywords
        query = Q()
        game_objects = []

        for data_type in self.models:
            model = self.models[data_type]
            model_filter = self.filters[data_type]()
            r = model_filter.filter_by_keywords(model, keywords)
            # if r is not an empty queryset
            if r:
                game_objects.append(r)

        return game_objects

    def get_storylines(self):
        return Storyline.objects.all()

    def get_character_relationships(self, character):
        return Relationship.objects.filter(Q(char1=character) | Q(char2=character))

    def get_character_traits_names(self, character_instance):
        return Trait.objects.filter(character=character_instance).values_list(
            "name", flat=True
        )

    def get_matching_facts(self, character_instance, keywords):
        """
        Get the facts that match the context keywords.
        """
        return Fact.objects.filter(
            Q(character=character_instance) & Q(keywords__in=keywords)
        )


def has_field(model_cls, field_name):
    try:
        model_cls._meta.get_field(field_name)
        return True
    except FieldDoesNotExist:
        return False
