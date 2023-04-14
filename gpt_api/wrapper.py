"""Wrapper for OpenAI ChatGPT-3.5 API."""

import os
import openai
from dotenv import load_dotenv
from typing import List

from npc.models import Message


class GPTWrapper:
    def __init__(self):
        load_dotenv()
        self.openai = openai
        self.openai.api_key = os.getenv("OPENAI_API_KEY")

    def generate_text(
        self, prompt: str, system: str, msg_history: List[Message], debug: bool = False
    ):
        """
        Generate text using the GPT-3.5 API.
        :param prompt:  The prompt to generate text from.
        :param system:  The system message to pass to the API.
        :param msg_history:  The message history to pass to the API.
        :param debug:  If True, print the generated text.
        :return:  The generated text.
        """

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
                "from the character described in the previous message.",
            },
        ]
        msg_history = msg_history[-10:] if len(msg_history) > 10 else msg_history
        for msg in msg_history:
            messages.append({"role": str(msg.role), "content": str(msg.text)})
            messages.append({"role": "system", "content": system})

        prompt = (
            "Player starts interacting with you. "
            "Reply to his message while always keeping in mind "
            "your character information: '" + prompt + "'"
        )
        messages.append({"role": "user", "content": prompt})

        if len(messages) > 2:
            print(messages[-2:])
        else:
            print(messages)

        response = self.openai.ChatCompletion.create(
            model="gpt-3.5-turbo", messages=messages
        )
        generated_text = response["choices"][0]["message"]["content"]
        return generated_text
