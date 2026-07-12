import os
import sys
import django

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'nuam.settings')
django.setup()

from Intranet.models import User

print("Registered users and their groups:")
for user in User.objects.all():
    groups = list(user.groups.values_list('name', flat=True))
    print(f" - {user.email} (ID: {user.id}) -> Groups: {groups}")
