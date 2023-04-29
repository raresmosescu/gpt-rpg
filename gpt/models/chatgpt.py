import os
import openai
from dotenv import load_dotenv
from typing import List
import logging
import tiktoken

logger = logging.getLogger(__name__)

chatgpt = None


class ChatGPT:
    def check_messages(self, messages: List[dict]):
        for message in messages:
            self.message_is_valid(message)
        num_tokens = self.num_tokens_from_messages(messages)
        if num_tokens >= 4097:
            raise ValueError(
                f"Number of tokens ({num_tokens}) exceeds the maximum number of tokens "
                f"allowed by the API (4096)"
            )
        return True

    @staticmethod
    def generate_text(messages):
        """
        Generate text using the GPT-3.5 API.
        :param messages: A list of messages, each message is a dictionary with
            a "role" key and a "content" key.
        :return: The generated text.
        """
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo", messages=messages
        )
        generated_text = response["choices"][0]["message"]["content"]
        return generated_text

    @staticmethod
    def message_is_valid(message: dict):
        if not isinstance(message, dict):
            raise ValueError("Message must be a dictionary")
        if "role" not in message:
            raise ValueError("Message must have a 'role' key")
        if "content" not in message:
            raise ValueError("Message must have a 'content' key")
        if message["role"] not in ["user", "system", "assistant"]:
            raise ValueError("Message role must be 'user', 'system', or 'assistant'")
        if not isinstance(message["content"], str):
            raise ValueError("Message content must be a string")
        return True

    @staticmethod
    def num_tokens_from_messages(messages, model="gpt-3.5-turbo"):
        """Returns the number of tokens used by a list of messages."""
        try:
            encoding = tiktoken.encoding_for_model(model)
        except KeyError:
            encoding = tiktoken.get_encoding("cl100k_base")
        if model == "gpt-3.5-turbo":  # note: future models may deviate from this
            num_tokens = 0
            for message in messages:
                # every message follows <im_start>{role/name}\n{content}<im_end>\n
                num_tokens += 4
                for key, value in message.items():
                    num_tokens += len(encoding.encode(value))
                    if key == "name":  # if there's a name, the role is omitted
                        num_tokens += -1  # role is always required and always 1 token
            num_tokens += 2  # every reply is primed with <im_start>assistant
            return num_tokens
        else:
            raise NotImplementedError(
                f"""num_tokens_from_messages() is not presently implemented for \
                model {model}. 
                See https://github.com/openai/openai-python/blob/\
                main/chatml.md for information on how messages are converted \
                to tokens."""
            )


def create_or_get_instance():
    global chatgpt
    if chatgpt is None:
        chatgpt = ChatGPT()
    return chatgpt
