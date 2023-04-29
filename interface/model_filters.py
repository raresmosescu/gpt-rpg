from django.db.models import Q
from typing import List
from django.db.models import Model


class NameAndDescriptionFilter:
    def filter_by_keywords(self, instance: Model, keywords: List[str]):
        query = Q()
        for keyword in keywords:
            query |= Q(name__icontains=keyword) | Q(description__icontains=keyword)
        return instance.objects.filter(query)


class CharacterFilter:
    def filter_by_keywords(self, instance: Model, keywords: List[str]):
        query = Q()
        for keyword in keywords:
            query |= Q(name__icontains=keyword) | Q(backstory__icontains=keyword)
        return instance.objects.filter(query)


class RelationshipFilter:
    def filter_by_keywords(self, instance: Model, keywords: List[str]):
        query = Q()
        for keyword in keywords:
            query |= Q(char1__name__icontains=keyword) | Q(
                char1__name__icontains=keyword
            )
        return instance.objects.filter(query)
