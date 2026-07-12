import os
import sys
import django

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'nuam.settings')
django.setup()

from django.db import connection

with connection.cursor() as cursor:
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()
    print("Tables in database:")
    for t in tables:
        # Check count of rows
        cursor.execute(f"SELECT COUNT(*) FROM `{t[0]}`")
        count = cursor.fetchone()[0]
        print(f" - {t[0]}: {count} rows")
