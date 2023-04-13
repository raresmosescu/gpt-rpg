"""Wrapper for OpenAI ChatGPT-3.5 API."""

import os
import openai
from dotenv import load_dotenv

load_dotenv("../.env")

openai.api_key = os.getenv("OPENAI_API_KEY")


def generate_text(prompt):
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                # {"role": "system", "content": "You are a teacher."},
                {"role": "user", "content": prompt},
            ],
        )
        generated_text = response["choices"][0]["message"]["content"]
        return generated_text