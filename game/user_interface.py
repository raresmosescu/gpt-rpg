"""
This file contains the UserInterface class, which is responsible for
handling all user input and output.
"""
from npc.models import Character
from game import config as game_config
import asyncio
from npc.conversation import Conversation


class UserInterface:
    def __init__(self, player: Character):
        self.view = game_config.VIEW_MAIN
        self.print_start_message()
        self.input_options = {}
        self.player = player

    @staticmethod
    def print_start_message():
        print("Welcome to the game!")

    async def main_view(self):
        print("Main menu. What would you like to do?")
        await self.refresh_input_options()
        user_input = input("Enter your choice: ")
        await self.handle_user_input(user_input)

    async def update_input_options(self):
        if self.view == game_config.VIEW_MAIN:
            self.input_options = {
                "1": {
                    "action": self.npc_conversation_options_view,
                    "label": "View all characters you can talk to",
                    "view": game_config.VIEW_CHARACTERS,
                },
                "2": {
                    "action": self.end_game,
                    "label": "End the game",
                },
            }
        elif self.view == game_config.VIEW_CHARACTERS:
            self.input_options = {}
            i = 1
            self.input_options[str(i)] = {
                "action": self.back_to_main_menu,
                "label": "Back to main menu",
                "view": game_config.VIEW_MAIN,
            }
            i += 1
            for character in await Character.exclude(is_player=True).all():
                self.input_options[character.name] = {
                    "action": self.npc_conversation_view,
                    "label": character.name,
                    "args": [character],
                    "view": game_config.VIEW_CONVERSATION,
                }
                i += 1

        elif self.view == game_config.VIEW_CONVERSATION:
            self.input_options = {
                "1": {
                    "action": self.back_to_main_menu,
                    "label": "Back to main menu",
                    "view": game_config.VIEW_MAIN,
                },
            }

    async def refresh_input_options(self):
        await self.update_input_options()
        self.print_input_options()

    def print_input_options(self):
        for option, details in self.input_options.items():
            print(f"{option}: {details['label']}")

    async def handle_user_input(self, user_input):
        if user_input in self.input_options:
            print(user_input)
            choice = self.input_options[user_input]
            print(choice)
            self.view = choice["view"]
            if "args" in choice:
                await choice["action"](*choice["args"])
            else:
                await choice["action"]()
        else:
            print("Invalid option.")
            await self.refresh_input_options()

    async def npc_conversation_view(self, character):
        await self.refresh_input_options()
        # create a new conversation between the player and the character
        conversation = await Conversation.create(char1=self.player, char2=character)
        print(f"Write anything to talk to {character.name}...")
        user_input = input("Enter your option: ")
        await self.handle_conversation_input(user_input, character, conversation)

    async def handle_conversation_input(self, user_input, character, conversation):
        if user_input == "1":
            await self.back_to_main_menu()
        else:
            reply_obj = await conversation.talk(user_input)
            print("Response: " + reply_obj.text)
            await self.npc_conversation_view(character)

    # async def handle_npc_conversation_options_input(self, user_input):
    #     choice = self.input_options[user_input]
    #     choice["action"](*choice["args"])

    async def npc_conversation_options_view(self):
        await self.refresh_input_options()
        characters = await Character.all()
        user_input = input("Enter your option: ")
        await self.handle_user_input(user_input)

    async def end_game(self):
        print("Thanks for playing!")
        exit()

    async def back_to_main_menu(self):
        self.view = game_config.VIEW_MAIN
        await self.main_view()
