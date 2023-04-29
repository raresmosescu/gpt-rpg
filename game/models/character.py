from django.db import models

from game.mixins import KeywordMixin

# Create your models here.


class Character(models.Model):
    name = models.CharField(max_length=100, unique=True)
    backstory = models.CharField(max_length=1000, null=True, blank=True)
    current_objective = models.CharField(max_length=1000, null=True, blank=True)
    location = models.ForeignKey(
        "Location",
        on_delete=models.CASCADE,
        related_name="characters",
    )
    # this is helpful for the GPT-3.5 API to generate what the character is doing
    # right now, where the character is, etc.
    active_quest = models.ForeignKey(
        "Quest",
        on_delete=models.CASCADE,
        related_name="characters",
        null=True,
        blank=True,
    )
    relationships = models.ManyToManyField(
        "Character",
        through="Relationship",
        related_name="related_to",
        null=True,
        blank=True,
    )
    is_player = models.BooleanField(default=False)

    def __str__(self):
        return self.name


class Relationship(models.Model):
    char1 = models.ForeignKey(
        "Character", related_name="char1_relationships", on_delete=models.CASCADE
    )
    char2 = models.ForeignKey(
        "Character", related_name="char2_relationships", on_delete=models.CASCADE
    )
    type = models.CharField(max_length=50)
    description = models.CharField(max_length=200, null=True)

    def __str__(self):
        return f"{self.type.capitalize()} ({self.char1.name}, {self.char2.name})"


class Trait(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.CharField(max_length=1000, null=True)
    character = models.ForeignKey(
        "Character", on_delete=models.CASCADE, related_name="traits", null=True
    )

    def __str__(self):
        return self.name


class Fact(KeywordMixin, models.Model):
    """
    The facts are the memory of the character, his knowledge about the world, himself,
    and the people around him. They will be used to generate the context for the
    GPT-3.5 API.

    The facts will be queried and only the best matching facts will be used to generate
    the context. Example: if the character is in a forest, the character will have a
    fact that says "I am in a forest". If the character is in a forest and the user
    asks the character about the forest, the character will be able to generate a
    context that says "I am in a forest" and the GPT-3.5 API will be able to generate
    a response that is more relevant to the conversation.
    """

    character = models.ForeignKey(
        "Character", on_delete=models.CASCADE, related_name="facts"
    )
    fact = models.CharField(max_length=255)
    # the category of the fact, e.g. "general", "location", "character", "item"
    category = models.CharField(max_length=32, default="general")
    keywords = models.CharField(max_length=255)

    def __str__(self):
        return self.fact

    def save(self, *args, **kwargs):
        # use gpt 3 to generate keywords for the fact
        self.keywords = self.fetch_keywords(self.fact)
        super().save(*args, **kwargs)
