from typing import List

from interface.game_data import GameData
from interface.gpt_controller import GPTController


class ContextManager:
    def __init__(self, game_data: GameData, gpt_controller: GPTController):
        self._context_list = []
        self._context_summary = ""
        self._game_data = game_data
        self._gpt_controller = gpt_controller

    def generate_context_from_keywords(self, keywords: List[str]):
        """
        This method takes a list of keywords and returns a context summary.
        """
        self._context_list = self._game_data.get_all_data_from_keywords(keywords)
        self._context_summary = (
            self._gpt_controller.generate_summary_from_context_model_list(
                self._context_list
            )
        )
        return self._context_summary

    def generate_character_context(self, character_instance, sender_character_instance):
        """
        This method takes a character name and returns a context summary.
        """
        name = character_instance.name
        backstory = character_instance.backstory
        current_objective = character_instance.current_objective
        traits = self.generate_traits_context(character_instance)
        location = character_instance.location
        relationships = self.generate_relationships_context(character_instance)

        sender_name = sender_character_instance.name

        context = f"You are {name}, a character in an RPG game.\n"
        if traits:
            context += f"{name} has the following traits: \n{traits}.\n"

        context += f"{name} has the following relationships: \n{relationships}.\n"
        context += f"{name}'s backstory is: {backstory}.\n"
        context += f"{name}'s current objective is: {current_objective}.\n"
        if location:
            context += f"{name} is currently located in {location}.\n"

        # overarching story context
        context += (
            f"Plot of the game: {self._game_data.get_storylines()[0].description}\n"
        )
        context += "You are currently playing as the character described above.\n"
        context += (
            "You must always talk as this character, including respecting "
            "his/her personality.\n"
        )
        context += f"You can only see the world through {name}'s eyes.\n"
        context += f"You have to use {name}'s knowledge to achieve your goals.\n"
        context += f"You can have selfish actions, but you must justify them.\n"
        context += f"*You are talking with {sender_name}*: \n"

        return context

    def add_context_to_prompt(
        self, prompt, keywords_context, conversation_summary, character
    ):
        """
        This method takes a prompt and a context and returns a prompt that combines both.
        """
        # add quotes to prompt
        prompt = f"{character.name}: {prompt}"
        if keywords_context:
            prompt += "\n\nContext:\n\n"
            prompt += keywords_context
        if conversation_summary:
            prompt += "\n\nPast conversation summary:\n\n"
            prompt += conversation_summary
        return prompt

    def generate_relationships_context(self, character_instance):
        """
        This method takes a list of relationships and returns a context summary.
        """
        relationships = self._game_data.get_character_relationships(character_instance)

        context = ""
        for relationship in relationships:
            if relationship.char1 == character_instance:
                context += f"{relationship.char2.name} - {relationship.type}.\n"
            else:
                context += f"{relationship.char1.name} - {relationship.type}.\n"
        return context

    def generate_traits_context(self, character_instance):
        """
        This method takes a list of traits and returns a context summary.
        """
        traits_names = self._game_data.get_character_traits_names(character_instance)

        context = ""
        for trait_name in traits_names:
            context += f"{trait_name}, "
        return context

    @property
    def get_context_list(self):
        return self._context_list

    @property
    def get_context_summary(self):
        return self._context_summary


# for each
