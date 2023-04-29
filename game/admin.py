from django.contrib import admin

# Register your models here.

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
)


class TraitInline(admin.TabularInline):
    model = Trait
    extra = 1


class CharacterAdmin(admin.ModelAdmin):
    inlines = [TraitInline]
    list_display = ("name", "location", "is_player")
    list_filter = ["is_player"]
    search_fields = ["name", "backstory", "current_objective"]


# register all the models
admin.site.register(Location)
admin.site.register(Item)
admin.site.register(Quest)
admin.site.register(Event)
admin.site.register(Faction)
admin.site.register(Storyline)
admin.site.register(Habit)
admin.site.register(Tradition)
admin.site.register(Character, CharacterAdmin)
admin.site.register(Relationship)
admin.site.register(Trait)
