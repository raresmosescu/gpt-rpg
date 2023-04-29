from tortoise import fields, models


class Item(models.Model):
    id = fields.IntField(pk=True)
    name = fields.CharField(max_length=255)
    description = fields.TextField()
    item_type = fields.CharField(max_length=255)
    weight = fields.FloatField(default=0)
    value = fields.FloatField(default=0)

    def __str__(self):
        return self.name
