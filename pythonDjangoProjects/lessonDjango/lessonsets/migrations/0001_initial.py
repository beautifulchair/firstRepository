# Generated by Django 3.2.6 on 2021-09-07 09:41

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Team',
            fields=[
                ('name', models.CharField(max_length=10, primary_key=True, serialize=False, unique=True)),
                ('birthday', models.DateField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='Person',
            fields=[
                ('name', models.CharField(max_length=10, primary_key=True, serialize=False, unique=True)),
                ('gender', models.CharField(choices=[('M', 'male'), ('F', 'female')], max_length=1, null=True)),
                ('birthday', models.DateField(auto_now_add=True)),
                ('url_page', models.URLField(null=True)),
                ('image', models.ImageField(upload_to='', verbose_name='images/photo1.png ')),
                ('team', models.ManyToManyField(blank=True, to='lessonsets.Team')),
            ],
        ),
    ]
