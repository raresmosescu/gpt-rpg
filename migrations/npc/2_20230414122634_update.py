from tortoise import BaseDBAsyncClient


async def upgrade(db: BaseDBAsyncClient) -> str:
    return """
        ALTER TABLE "character" ADD "is_player" BOOL NOT NULL  DEFAULT False;
        CREATE TABLE IF NOT EXISTS "message" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "role" VARCHAR(50),
    "text" TEXT NOT NULL,
    "timestamp" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "receiver_id" INT NOT NULL REFERENCES "character" ("id") ON DELETE CASCADE,
    "sender_id" INT NOT NULL REFERENCES "character" ("id") ON DELETE CASCADE
);;"""


async def downgrade(db: BaseDBAsyncClient) -> str:
    return """
        ALTER TABLE "character" DROP COLUMN "is_player";
        DROP TABLE IF EXISTS "message";"""
