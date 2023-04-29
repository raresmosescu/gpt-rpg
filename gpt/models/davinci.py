import os
import openai
from dotenv import load_dotenv
from typing import List
import logging

logger = logging.getLogger(__name__)

davinci3 = None


class GPTDavinci3:
    def __init__(self):
        self.model = "text-davinci-003"

    def complete(self, prompt: str, max_tokens: int = 100):
        logger.warning(f"Max tokens: {max_tokens}")
        response = openai.Completion.create(
            engine=self.model,
            prompt=prompt,
            max_tokens=max_tokens,
        )
        return response.choices[0].text


def create_or_get_instance():
    global davinci3
    if davinci3 is None:
        davinci3 = GPTDavinci3()
    return davinci3
