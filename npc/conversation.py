"""
This file will handle all conversation between the player and NPCs and between NPCs.
"""
import asyncio
import random

from npc.config import NUM_TRAITS, TRAITS
from npc.models import Character, Relationship, Trait, Backstory, Goal, Message
from gpt_api.wrapper import GPTWrapper
from tortoise.expressions import Q

from npc.utils import get_all_relationships_of_a_character

gpt = GPTWrapper()


class Conversation:
    def __init__(self, char1: Character, char2: Character):
        self.char1 = char1
        self.char2 = char2
        self.msg_history = []

    @classmethod
    async def create(cls, char1: Character, char2: Character):
        conversation = cls(char1, char2)
        await conversation.initialize()
        return conversation

    async def initialize(self):
        self.msg_history = await self.get_conversation_history()

    async def get_conversation_history(self):
        """
        Get the conversation history between two characters.

        A character can be either NPC or player.

        Returns:
            list: A list of messages sorted by timestamp. Used to pass to the gpt api.
        """

        # sort the messages by timestamp from oldest to newest,
        # removing messages with role="system" -> system message is not part of
        # the conversation and will be added later in the gpt api call
        conv_history = (
            await Message.filter(
                Q(sender=self.char1, receiver=self.char2)
                | Q(sender=self.char2, receiver=self.char1)
            )
            .exclude(role="system")
            .order_by("timestamp")
        )
        return conv_history

    async def get_char_system_message(self, character: Character):
        """
        Get the context of a character. This is used to pass to the gpt api as
        the system message.
        :param character: The character to get the context of.
        :return: A string containing the context of the character.
        """

        # get all relationships of this character
        relationships = await get_all_relationships_of_a_character(character)
        # get all traits of this character
        # check if the character has any traits
        traits = ""
        if len(await character.traits.all()) > 0:
            traits = ", ".join([t.name for t in await character.traits.all()])
        context = (
            f"Pretend this is an RPG game. You are an NPC named {character.name}.\n\n"
            + (f"Character traits:\n{traits}\n\n" if traits else "")
            + "\n\n"
            + "Character backstory:\n"
            + character.backstory
            + "\n\n"
            + "Character current objective:\n"
            + (character.current_objective if character.current_objective else "None")
            + "\n\n"
            + "Character relationships:\n"
            + relationships
        )
        return context

    async def talk(self, message):
        """
        A conversation between two characters (NPC or player). The conversation
        is handled by the gpt api.
        :param message: The message to send to the other character.
        :return: The reply from the other character.
        """
        system = await self.get_char_system_message(self.char2)

        # add the message to the conversation history
        reply = gpt.generate_text(message, system, self.msg_history, debug=True)

        # Create the message object
        # keep role of char1 always to user so that NPCs can talk to each other
        # TODO: find a better way to do this
        msg_obj = Message(
            sender=self.char1,
            receiver=self.char2,
            text=message,
            role="user",
        )
        # Add message to the conversation history
        self.msg_history.append(msg_obj)

        # Create the reply object
        msg_reply_obj = Message(
            sender=self.char2,
            receiver=self.char1,
            text=reply,
            role="assistant",
        )
        # Add reply to the conversation history
        self.msg_history.append(msg_reply_obj)

        # Save the messages to the database
        await msg_obj.save()
        await msg_reply_obj.save()

        return msg_reply_obj
