from django.db import models
from datetime import datetime

# Create your models here.
class Room(models.Model):
	roomID=models.SlugField(primary_key=True, max_length=20,unique=True)
	time = models.TimeField(default=datetime.now)
	def __str__(self):
		return self.roomID

class Message(models.Model):
	text=models.TextField(max_length=300)
	room=models.ForeignKey(Room, null=True, on_delete=models.CASCADE)
	time = models.TimeField(default=datetime.now)
	def __str__(self):
		return str(self.text)+str(self.time)
