from django.test import TestCase

# Create your tests here.
from Intranet.models import *
from django.contrib.auth.models import Group
from django.contrib.auth import get_user_model

User = get_user_model()

u = User.objects.get(email="admin@nuam.com")

grupo = Group.objects.get(name="Administrador")

u.groups.add(grupo)

u.save()

print(list(u.groups.values_list("name", flat=True)))