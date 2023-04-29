from typing import List

from gpt.models.davinci import create_or_get_instance as get_davinci3
from gpt.models.chatgpt import create_or_get_instance as get_chatgpt
from django.db.models import Model
from game.models import Character, Relationship
from interface.models import Message
from interface.game_data import has_field


class GPTController:
    def __init__(self):
        self.davinci3 = get_davinci3()
        self.chatgpt = get_chatgpt()

    def get_reply(self, prompt: str):
        return self.davinci3.complete(prompt)

    def get_keywords_from_conversation(self, conversation: str):
        instruction = (
            "List the names of the locations, people's names, quests, storylines, "
            "events, factions, items, and relationships that are mentioned in the "
            "conversation, maximum 2 words per listing, as comma-separated values:"
        )
        comma_separated_keywords = self.davinci3.complete(
            conversation + "\n\n" + instruction
        )
        return comma_separated_keywords.strip().split(",")

    def fix_message_for_gpt(self, message: str):
        instruction = (
            "Make this message readable for the gpt model "
            "without changing the meaning or tone: " + message
        )
        return self.davinci3.complete(instruction)

    def get_keywords_from_message(self, message: str):
        instruction = (
            "List the key words that are mentioned in the message above, "
            "maximum 2 words per listing, as comma-separated values:"
        )
        comma_separated_keywords = self.davinci3.complete(
            "Message: " + message + "\n\n" + instruction
        )
        return comma_separated_keywords.strip().split(", ")

    def generate_summary_from_context_model_list(self, context):
        """
        Generate a summary of the context.

        The summary should be a few sentences that summarize the context so that
        the gpt model can use it to generate a relevant response.
        """
        instruction = (
            "Summarize the following game information in a few sentences but don't "
            "remove the most important information about the game world, like names, "
            "locations, relationships, characters, events and so on:\n\n"
        )
        # check that all models in the context have a name and description
        input = ""
        summary = ""
        for obj_list in context:
            if isinstance(obj_list.first(), Character):
                # summary should contain the name + description of each object in the context
                for obj in obj_list:
                    input += str(obj.name) + "\n"
                    input += " - Backstory: " + str(obj.backstory) + "\n\n"

            elif isinstance(obj_list.first(), Relationship):
                # summary should contain the name + description of each object in the context
                input += "Relationships:\n"
                for obj in obj_list:
                    input += f"{obj.char1.name} and {obj.char2.name}: {obj.type}\n"

            else:
                if not has_field(obj_list.first(), "name") or not has_field(
                    obj_list.first(), "description"
                ):
                    continue

                # append the name of each class to the input as a header
                input += str(obj_list.first().__class__.__name__) + ":\n"
                # append the name and description of each object
                for obj in obj_list:
                    input += str(obj.name) + "\n"
                    input += " - Description: " + str(obj.description) + "\n\n"

        print(input)

        if input:
            summary = self.davinci3.complete(
                instruction + "\n\n" + input, max_tokens=600
            )
            return summary.strip()
        else:
            return ""

    def generate_summary_from_conversation(self, conversation: str):
        """
        Generate a summary of the conversation.

        The summary should be a few sentences that summarize the conversation so that
        the gpt model can use it to generate a relevant response.
        """
        instruction = (
            "Summarize the conversation, "
            "but keep the most important information about who, when, what, etc. "
            "Use bullet points:"
        )
        summary = self.davinci3.complete(
            conversation + "\n\n" + instruction, max_tokens=600
        )
        return summary.strip()

    def generate_text_response(
        self,
        prompt: str,
        context_str: str,
        msg_history: List[dict],
    ):
        messages = self.build_messages(prompt, context_str, msg_history)
        return self.chatgpt.generate_text(messages)

    def test_generate_text_response(self, prompt: str, context_str: str):
        messages = [
            {"role": "system", "content": context_str},  # character info
            {"role": "user", "content": prompt},
        ]
        return self.chatgpt.generate_text(messages)

    def provide_feedback(self, prompt: str, response: str, context_str: str):
        # TODO: implement this
        pass

    def build_messages(self, prompt: str, system: str, msg_history):
        # the system message will always be the first message
        # since only the last 10 messages are passed to the API
        # it will be relevant to the prompt
        messages = [
            {"role": "system", "content": system},
            {
                "role": "system",
                "content": "\n\nMax 50 words reply."
                + "\n\nDo not print instructions in your response."
                + "\n\nThe response needs to be a dialogue reply to the user / player"
                "or NPC from the character described in the previous message.",
            },
        ]
        msg_history = msg_history[-10:] if len(msg_history) > 10 else msg_history
        messages += msg_history

        messages.append({"role": "user", "content": prompt})
        return messages
