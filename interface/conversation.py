"""
This module contains the Conversation class, which is used to
manage the conversation between the user and the NPC.
"""
from interface.game_data import GameData
from interface.gpt_controller import GPTController
from interface.context_manager import ContextManager
from interface.models import Message
from django.db.models import Q


class Conversation:
    def __init__(self, sender, receiver):
        self.sender = sender  # object
        self.receiver = receiver  # object

        # if the receiver is a player, switch the sender and receiver so that the
        # receiver is always the NPC
        if receiver.is_player:
            self.sender, self.receiver = self.receiver, self.sender
        self._conversation_summary = ""
        self._game_data = GameData()
        self._gpt_controller = GPTController()
        self._context_manager = ContextManager(self._game_data, self._gpt_controller)
        self._message_history = self.get_messsage_history()
        self.max_message_history = 10

    def talk(self, message: str):
        """
        This method takes a message from the sender and returns a response from the
        receiver.
        """

        conversation_summary = self.get_conversation_summary()

        char_context = self._context_manager.generate_character_context(
            self.receiver, self.sender
        )
        print(char_context)

        # get keywords
        keywords = self._gpt_controller.get_keywords_from_message(message)
        # generate context from message
        print(keywords)

        keywords_context = self._context_manager.generate_context_from_keywords(
            keywords
        )

        print(keywords_context)

        # get recent message history (gpt can only handle a certain amount of tokens)
        if len(self._message_history) > self.max_message_history:
            recent_msg_history = self._message_history[: -self.max_message_history]
        else:
            recent_msg_history = self._message_history

        message_with_context = self._context_manager.add_context_to_prompt(
            message, keywords_context, conversation_summary, self.sender
        )

        print(message_with_context)

        # generate response from context
        response = self._gpt_controller.generate_text_response(
            message_with_context, char_context, recent_msg_history
        )

        self.save_sender_message(message)
        self.save_receiver_message(response)

        return response

    def save_sender_message(self, message):
        self._message_history.append({"role": "user", "content": message})
        Message.objects.create(
            message=message, sender=self.sender, receiver=self.receiver
        )

    def save_receiver_message(self, message):
        self._message_history.append({"role": "assistant", "content": message})
        Message.objects.create(
            message=message, sender=self.receiver, receiver=self.sender
        )

    def get_messsage_history(self):
        # get all messages from the database where the sender is either the sender or
        # the receiver and the receiver is either the sender or the receiver
        # then sort the messages by the timestamp
        # using Q objects

        message_history = []
        messages = Message.objects.filter(
            (Q(sender=self.sender) & Q(receiver=self.receiver))
            | (Q(sender=self.receiver) & Q(receiver=self.sender))
        ).order_by("timestamp")

        # for the player, he is always the sender, so we don't need to check if the
        # sender is the player, or modify the format of the message history
        for message in messages:
            if message.sender == self.sender:
                message_history.append({"role": "user", "content": message.message})
            else:
                message_history.append(
                    {"role": "assistant", "content": message.message}
                )

        return message_history

    def conversation_to_text(self, message_history):
        text = ""
        for m in message_history:
            if m["role"] == "user":
                text += f"{self.sender}: {m['content']}\n"
            else:
                text += f"{self.receiver}: {m['content']}\n"
        return text

    def get_conversation_summary(self, n=10):
        if len(self._message_history) < n + 10:
            return ""
        # every 20 messages, generate a new conversation summary
        if len(self._message_history) % n == 0:
            # e.g. get last 30 messages, excluding the last 10
            offset_message_history = self._message_history[-(n + 20) : -n]
            summary = self._gpt_controller.generate_summary_from_conversation(
                self.conversation_to_text(offset_message_history)
            )
            return summary
        else:
            return self._conversation_summary
