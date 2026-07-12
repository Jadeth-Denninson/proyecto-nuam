import os
import sys
import django

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'nuam.settings')
django.setup()

from Intranet.forms import CalificacionTributariaForm
from Intranet.models import User, instrumento_financiero

# Test with empty client
instrument = instrumento_financiero.objects.first()

post_data = {
    'cliente': '',
    'mercado': 'ACCIONES',
    'instrumento': instrument.instrumento_id if instrument else '',
    'valor_historico': '1500000',
    'fecha_pago': '2026-07-12',
    'dividendo': '500',
    'descripcion': 'Test Calificacion',
    'secuencia_evento': '999999',
    'anio': '2026',
    'isfut': 'True',
}

form = CalificacionTributariaForm(post_data)
if form.is_valid():
    print("Form is valid with empty client!")
else:
    print("Form is invalid with empty client!")
    print("Errors:", form.errors)
