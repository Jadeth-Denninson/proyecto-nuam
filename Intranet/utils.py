from .models import *
from django.forms.models import model_to_dict
from datetime import date, datetime
from decimal import Decimal
from uuid import UUID
from django.db.models import Model

def make_json_serializable(value):
    # Diccionarios
    if isinstance(value, dict):
        return {k: make_json_serializable(v) for k, v in value.items()}

    # Listas
    if isinstance(value, list):
        return [make_json_serializable(v) for v in value]

    # Tuplas
    if isinstance(value, tuple):
        return tuple(make_json_serializable(v) for v in value)

    # Fechas
    if isinstance(value, (date, datetime)):
        return value.isoformat()

    # Decimales
    if isinstance(value, Decimal):
        return str(value)

    # UUID
    if isinstance(value, UUID):
        return str(value)

    # Instancia de modelo Django (FK, OneToOne, ManyToOne)
    if isinstance(value, Model):
        return value.pk

    return value

def registrar_auditoria(usuario, accion, descripcion="", instancia_antes= None, instancia_despues = None, ):
    antes = model_to_dict(instancia_antes) if instancia_antes else None
    despues = model_to_dict(instancia_despues) if instancia_despues else None

    if instancia_antes:
      
      tabla = instancia_antes.__class__.__name__
      registro_id = instancia_antes.pk
    elif instancia_despues:
      
      tabla = instancia_despues.__class__.__name__
      registro_id = instancia_despues.pk

    # Hacemos Serializable:
    antes = make_json_serializable(antes) if antes is not None else None
    despues = make_json_serializable(despues) if despues is not None else None

    Auditoria.objects.create(
        usuario=usuario,
        tabla=tabla,
        registro_id=str(registro_id),
        accion=accion,
        descripcion=descripcion,
        valores_antes=antes,
        valores_despues=despues
    )
    
def update_or_create_with_auditoria(
    usuario,
    model_class,
    lookup: dict,
    defaults: dict,
    descripcion_crear="Creación de registro",
    descripcion_editar="Edición de registro",
):
    try:
        existente = model_class.objects.get(**lookup)
        antes = existente
        creado = False
    except model_class.DoesNotExist:
        existente = None
        antes = None
        creado = True

    obj, created_flag = model_class.objects.update_or_create(
        **lookup, defaults=defaults
    )

    if creado or created_flag:
        registrar_auditoria(
            usuario=usuario,
            accion="CREAR",
            descripcion=descripcion_crear,
            instancia_antes=None,
            instancia_despues=obj,
        )
    else:
        despues = obj
        registrar_auditoria(
            usuario=usuario,
            accion="EDITAR",
            descripcion=descripcion_editar,
            instancia_antes=antes,
            instancia_despues=obj,
        )

    return obj

def build_categorias_niveladas(valores=None):
    categorias = list(categoria_factor.objects.all())
    categorias_por_padre = {}
    for cat in categorias:
        categorias_por_padre.setdefault(cat.padre_id, []).append(cat)

    def aplanar(cat, lvl=0):
        salida = [{
            "categoria": cat,
            "nivel": lvl,
            "factores": [
                {"obj": f, "valor": valores.get(f.factor_id, 0) if valores else 0}
                for f in cat.factor_calificacion_set.all().order_by("factor_id")
            ]
        }]
        for sub in categorias_por_padre.get(cat.id, []):
            salida.extend(aplanar(sub, lvl + 1))
        return salida

    niveles = []
    for raiz in categorias_por_padre.get(None, []):
        niveles.extend(aplanar(raiz))
    return niveles

def build_factores_sueltos(valores=None):
    sueltos = factor_calificacion.objects.filter(categoria__isnull=True)
    return [
        {"obj": f, "valor": valores.get(f.factor_id, 0) if valores else 0}
        for f in sueltos
    ]

def calcular_factores(factores, factores_total):
  total = sum(factores.get(fid, 0) for fid in factores_total)

  result = {}

  for factor in factor_calificacion.objects.all():
    fid = factor.factor_id
    valor = factores.get(fid, 0)

    if total > 0:
      valor_calc = round(valor / total, 6)

      if fid in factores_total:
        valor_calc = min(1, valor_calc)
    
    result[fid] = valor_calc
  return result

def lista_contactos(request):
    try:
        user_actual = User.objects.get(email=request.user.email)
        print(user_actual)
    except User.DoesNotExist:
        return []

    rol_actual = user_actual.groups.first()  # o user_actual.rol según lo que tengas implementado
    contactos = User.objects.filter(groups=rol_actual).exclude(id=user_actual.id)

    return contactos   # ahora no tenemos una vista sino una función 