from tortoise import fields, models


class Location(models.Model):
    id = fields.IntField(pk=True)
    name = fields.CharField(max_length=255)
    # location type examples: town, village, forest, cave, building, etc.
    type = fields.CharField(max_length=255)
    description = fields.TextField()
    parent_location = fields.ForeignKeyField(
        "locations.Location", related_name="sub_locations", null=True, default=None
    )

    def __str__(self):
        return self.name

    @staticmethod
    async def get_sub_locations(parent_location):
        sub_locations = await Location.filter(parent_location=parent_location).all()
        return sub_locations
