# postgres database
import os
from tortoise import Tortoise

POSTGRES_USERNAME = "postgres"
POSTGRES_PASSWORD = ""
POSTGRES_DB = "postgres"


# SQLALCHEMY_DATABASE_URI = f"postgresql://{POSTGRES_USERNAME}@localhost/{POSTGRES_DB}"
# SQLALCHEMY_TRACK_MODIFICATIONS = False


# use tortoise orm
TORTOISE_ORM = {
    "connections": {
        "default": f"postgres://{POSTGRES_USERNAME}@localhost/{POSTGRES_DB}"
    },
    "apps": {
        "npc": {
            "models": ["npc.models"],
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
    },
}


async def init_orm():
    await Tortoise.init(config=TORTOISE_ORM)
    await Tortoise.generate_schemas()


Tortoise.init_models(["npc.models"], "npc")
Tortoise.init_models(["event_system.models"], "event_system")
Tortoise.init_models(["aerich.models"], "aerich")
