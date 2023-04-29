"""
The context is the information that the GPT-3.5 API needs to accurately
generate a response that is not spit out gibberish. The context is
the information that the model needs to know about the game, the world, the player,
the NPCs and their personality, their relationships, their location, and so on.

How it works:
1. A character sends a message to some other character. A character can be a player
or an NPC.
2. The message is analyzed by the context analyzer.
3. The context analyzer extracts the information from the message that is most relevant
to the conversation.
4. This information is packaged in the context and sent to the GPT-3.5 API.
5. The GPT-3.5 API uses the context, prompt and past messages to generate a response.
"""

sample_gpt_data = {
    "prompt": {"role": "user", "content": "msg1"},
    # this part is what this file is about
    "context": [
        {"role": "system", "content": "context1"},  # character info
        {"role": "system", "content": "context2"},  # player info (relationship, etc)
        {"role": "system", "content": "context3"},  # game info (location, etc)
    ],
    "history": [
        {"role": "user", "content": "msg1"},
        {"role": "assistant", "content": "msg2"},
        {"role": "user", "content": "msg3"},
        {"role": "assistant", "content": "msg4"},
    ],
}
