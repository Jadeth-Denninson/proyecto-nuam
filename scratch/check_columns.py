import os
import sys
import django

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'nuam.settings')
django.setup()

from django.db import connection

with connection.cursor() as cursor:
    cursor.execute("DESCRIBE `Intranet_calificacion_tributaria`")
    cols = cursor.fetchall()
    print("Columns in Intranet_calificacion_tributaria:")
    for col in cols:
        print(f" - {col[0]} ({col[1]})")

    cursor.execute("DESCRIBE `Intranet_solicitud`")
    cols = cursor.fetchall()
    print("\nColumns in Intranet_solicitud:")
    for col in cols:
        print(f" - {col[0]} ({col[1]})")
