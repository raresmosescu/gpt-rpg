import asyncio

from game import game

# test the database connection
from npc.models import Character
from database.config import init_orm
import asyncio


# async def test_db_connection():
#     # select all characters
#     characters = await Character.all()
#     # print the number of characters
#     print(f"Number of characters: {len(characters)}")
#
#
# asyncio.run(test_db_connection())


async def main():
    await init_orm()

    PLAYER = await Character.filter(is_player=True).first()

    await game.set_up_game()

    UI = game.UserInterface(player=PLAYER)

    await UI.main_view()


asyncio.run(main())
