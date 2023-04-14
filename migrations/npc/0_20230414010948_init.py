from tortoise import BaseDBAsyncClient


async def upgrade(db: BaseDBAsyncClient) -> str:
    return """
        CREATE TABLE IF NOT EXISTS "backstory" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "text" VARCHAR(1000) NOT NULL
);
CREATE TABLE IF NOT EXISTS "character" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL UNIQUE,
    "backstory" VARCHAR(1000) NOT NULL,
    "current_objective" VARCHAR(1000)
);
CREATE TABLE IF NOT EXISTS "goal" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS "relationship" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "type" VARCHAR(50) NOT NULL,
    "char1_id" INT NOT NULL REFERENCES "character" ("id") ON DELETE CASCADE,
    "char2_id" INT NOT NULL REFERENCES "character" ("id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "trait" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL
);
COMMENT ON TABLE "trait" IS 'A trait is a single property of a personality.';
CREATE TABLE IF NOT EXISTS "event" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "event_type" VARCHAR(50) NOT NULL,
    "description" VARCHAR(1000),
    "source_character_id" INT REFERENCES "character" ("id") ON DELETE CASCADE,
    "target_character_id" INT REFERENCES "character" ("id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "aerich" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "version" VARCHAR(255) NOT NULL,
    "app" VARCHAR(100) NOT NULL,
    "content" JSONB NOT NULL
);
CREATE TABLE IF NOT EXISTS "character_trait" (
    "character_id" INT NOT NULL REFERENCES "character" ("id") ON DELETE CASCADE,
    "trait_id" INT NOT NULL REFERENCES "trait" ("id") ON DELETE CASCADE
);"""


async def downgrade(db: BaseDBAsyncClient) -> str:
    return """
        """
