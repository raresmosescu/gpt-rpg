from django.db import models
from game.models import Character


# Create your models here.
class Message(models.Model):
    message = models.TextField()

    sender = models.ForeignKey(
        Character, on_delete=models.CASCADE, related_name="sender"
    )
    receiver = models.ForeignKey(
        Character, on_delete=models.CASCADE, related_name="receiver"
    )
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        # timestamp(only date and hour and second), sender, receiver, message - readable
        return (
            f"({self.timestamp.strftime('%Y-%m-%d %H:%M:%S')}) - {self.sender} -> "
            f"{self.receiver} - {self.message[:40]}"
        )
