from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.

class Team(models.Model):
    name = models.CharField(max_length=10, primary_key=True, unique=True)
    birthday = models.DateField(auto_now=False, auto_now_add=True)
    def __str__(self):
        return self.name


class Person(models.Model):
    name = models.CharField(max_length=10, primary_key=True, unique=True)
    GENDER_CHOICE = [
        ('M', 'male'),
        ('F', 'female'),
    ]
    gender = models.CharField(max_length=1, choices=GENDER_CHOICE, null=True)
    birthday = models.DateField(auto_now=False, auto_now_add=True)
    team = models.ManyToManyField(Team, blank=True)
    #url_page = models.URLField(blank = True)
    #image = models.ImageField("images/photo1.png ")
    def __str__(self):
        return self.name

