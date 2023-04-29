# postgres database
import os
from tortoise import Tortoise

POSTGRES_USERNAME = "postgres"
POSTGRES_PASSWORD = ""
POSTGRES_DB = "postgres"

# SQLALCHEMY_DATABASE_URI = f"postgresql://{POSTGRES_USERNAME}@localhost/{POSTGRES_DB}"
# SQLALCHEMY_TRACK_MODIFICATIONS = False


# use tortoise orm
# TORTOISE_ORM = {
#     "connections": {
#         "default": {
#             "engine": "tortoise.backends.asyncpg",
#             "credentials": {
#                 "port": 5432,
#                 "database": "postgres",
#                 "host": "localhost",
#                 "user": "postgres",
#                 "password": None,
#             },
#         }
#     },
#     "apps": {
#         "gpt-rpg": {
#             "models": [
#                 "npc.models",
#                 "event_system.models",
#                 "aerich.models",
#                 "inventory.models",
#                 "locations.models",
#             ],
#             "default_connection": "default",
#         }
#     },
# }


TORTOISE_ORM = {
    "connections": {
        "default": {
            "engine": "tortoise.backends.asyncpg",
            "credentials": {
                "port": 5432,
                "database": "postgres",
                "host": "localhost",
                "user": "postgres",
                "password": None,
            },
        }
    },
    "apps": {
        "npc": {
            "models": ["npc.models"],
            "default_connection": "default",
        },
        "inventory": {
            "models": ["inventory.models"],
            "default_connection": "default",
        },
        "event_system": {
            "models": ["event_system.models"],
            "default_connection": "default",
        },
        "aerich": {
            "models": ["aerich.models"],
            "default_connection": "default",
        },
        "locations": {
            "models": ["locations.models"],
            "default_connection": "default",
        },
    },
}


async def init_orm():
    await Tortoise.init(config=TORTOISE_ORM)
    await Tortoise.generate_schemas()


Tortoise.init_models(["npc.models"], "npc")
Tortoise.init_models(["event_system.models"], "event_system")
Tortoise.init_models(["aerich.models"], "aerich")
Tortoise.init_models(["inventory.models"], "inventory")
Tortoise.init_models(["locations.models"], "locations")
