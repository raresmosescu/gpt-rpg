# """
# Manage the characters in the game.
# """
# from npc.models import Character
#
#
# class CharacterManager:
#     """
#     This class is used to define the types of characters that can occur in the game.
#     """
#
#     async def add_character(self, character: Character):
#         await character.save()
#
#     async def get_characters(self):
#         return await Character.all().prefetch_related("relationships")
#
#     async def get_character(self, index: int):
#         return await Character.filter(id=index).first().prefetch_related("relationships")
#
#     async def get_character_by_name(self, name: str):
#         return await Character.filter(name=name).first().prefetch_related("relationships")
#
#     async def get_character_by_objective(self, objective: str):
#         return (
#             await Character.filter(objective=objective)
#             .first()
#             .prefetch_related("relationships")
#         )
#
#     async def get_character_by_backstory(self, backstory: str):
#         return (
#             await Character.filter(backstory=backstory)
#             .first()
#             .prefetch_related("relationships")
#         )
#
#     async def get_character_by_trait(self, trait: str):
#         return (
#             await Character.filter(traits__contains=[trait])
#             .first()
#             .prefetch_related("relationships")
#         )
#
#     async def get_character_by_relationship(self, relationship: Relationship):
#         return (
#             await Character.filter(relationships__contains=[relationship])
#             .first()
#             .prefetch_related("relationships")
#         )
#
#     async def get_character_by_relationship_type(self, relationship_type: str):
#         return (
#             await Character.filter(relationships__type=relationship_type)
#             .first()
#             .prefetch_related("relationships")
#         )
#
#     async def get_character_by_relationship_character(self, character: Character):
#         return (
#             await Character.filter(relationships__character=character)
#             .first()
#             .prefetch_related("relationships")
#         )
#
#     async def get_character_by_relationship_strength(self, strength: int):
#         return (
#             await Character.filter(relationships__strength=strength)
#             .first()
#             .prefetch_related("relationships")
#         )
#
#     async def get_character_by_relationship_type_and_character(
#         self, relationship_type: str, character: Character
#     ):
#         return (
#             await Character.filter(relationships__type=relationship_type)
#             .filter(relationships__character=character)
#             .first()
#             .prefetch_related("relationships")
#         )
#
#     async def get_character_by_relationship_type_and_strength(
#         self, relationship_type: str, strength: int
#     ):
#         return (
#             await Character.filter
