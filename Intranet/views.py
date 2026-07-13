from django.contrib import messages
from django.http import HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from .models import *
from .forms import *
from hashlib import sha512
from django.contrib.auth.models import Group
from django.contrib.auth.decorators import login_required, permission_required
from django.views.decorators.http import require_POST
from django.contrib.auth import authenticate, login, logout
from .decorators import role_required
from csv import DictReader as csvr
from django.db.models import Q
from .utils import *

# Create your views here.

def index(request):
  return render(request, "Intranets/index.html")

def VW_login(request):
  motivo_qs = request.GET.get("required")
    
  if motivo_qs == "forbidden":
      motivo = "Para acceder a esta página debe iniciar sesión."
  elif motivo_qs == "no_permission":
      motivo = "No tiene permisos suficientes para acceder a esta sección."
  else:
      motivo = None

  if request.user.is_authenticated and not motivo:
    if request.user.groups.filter(name="Administrador").exists() or request.user.is_superuser:
      return redirect("admin")
    elif request.user.groups.filter(name="Auditor").exists():
      return redirect("auditor")
    elif request.user.groups.filter(name="Corredor").exists():
      return redirect("corredor")
    elif request.user.groups.filter(name="Cliente").exists():
      return redirect("cliente_dashboard")
    elif request.user.groups.filter(name="Bolsa").exists():
      return redirect("bolsa")
    else:
      # Usuario logueado pero sin rol válido
      # Podrías redirigir a una página neutral o mostrar error
      return render(request, "Intranets/login.html", {
        "form": LoginForm(),
        "motivo": "Su usuario no tiene un rol válido asociado."
      })

  error = None
  if request.method == "POST":
    form = LoginForm(request.POST)
    if form.is_valid():
      email = form.cleaned_data["email"]
      password = form.cleaned_data["password"]
      
      user = authenticate(request, email = email, password = password)

      if user is None:
        error = "Correo o Contraseña Incorrectos"
        return render(request, "Intranets/login.html", {"form": form, "error": error})

      login(request, user)
      
      # Registrar inicio de sesión en Azure Cosmos DB
      try:
          from .cosmos_logger import log_event_to_cosmos
          log_event_to_cosmos("INICIO_SESION", user.email, {"ip": request.META.get('REMOTE_ADDR')})
      except Exception:
          pass

      if user.groups.filter(name="Administrador").exists() or user.is_superuser:
        return redirect("admin")
      elif user.groups.filter(name="Auditor").exists():
        return redirect("auditor")
      elif user.groups.filter(name="Corredor").exists():
        return redirect("corredor")
      elif user.groups.filter(name="Cliente").exists():
        return redirect("cliente_dashboard")
      elif user.groups.filter(name="Bolsa").exists():
        return redirect("bolsa")
      else:
        error = "Rol Corrupto o No Válido"
  else:
    form = LoginForm()

  return render(request, "Intranets/login.html", {"form": form, "error": error, "motivo": motivo})

@login_required()

def VW_intranet(request):
    redirecciones = {
        "Auditor": "auditor",
        "Corredor": "corredor",
        "Administrador": "admin",
        "Bolsa": "bolsa",
        "Cliente": "cliente_dashboard"
    }

    grupo = request.user.groups.first()
    return redirect(redirecciones.get(grupo.name, "login"))

@login_required()

def VW_logout(request):
  usuario_email = request.user.email
  logout(request)
  
  # Registrar cierre de sesión en Azure Cosmos DB
  try:
      from .cosmos_logger import log_event_to_cosmos
      log_event_to_cosmos("CIERRE_SESION", usuario_email, {"ip": request.META.get('REMOTE_ADDR')})
  except Exception:
      pass

  return redirect('login')

#def VW_login(request): # OG Function
#  error = None
#  if request.method == "POST":
#    form = LoginForm(request.POST)
#    if form.is_valid():
#      email = form.cleaned_data["email"]
#      password = form.cleaned_data["password"]
#      hashed_password = sha512(password.encode()).hexdigest()
#
#      try:
#        user = usuario.objects.get(email= email, password = hashed_password)
#
#        rol = user.rol.nombre_rol.lower()
#
#        if rol == "administrador":
#          return redirect("admin")
#        elif rol == "auditor":
#          return redirect("auditor")
#        elif rol == "corredor":
#          return redirect("corredor")
#        else:
#          raise ValueError()
#      except usuario.DoesNotExist:
#        error = "Correo o Contraseña Incorrectos"
#      except ValueError:
#        error = "Rol Corrupto o No Válido"
#      except Exception as e:
#        error = e
#  else:
#    form = LoginForm()
#
#  return render(request, "Intranets/login.html", {"form": form, "error": error})

###### INTRANETS

@login_required()
@role_required(["Administrador"])
def admin(request):
  contactos = lista_contactos(request)
  buscar = request.GET.get("buscar")
  if buscar:
      contactos = contactos.filter(email__icontains=buscar)

  chat = None
  abrir_chat = False
  mensajes = None
  destino = None
  user_id = request.POST.get("user_id") or request.GET.get("user_id") #  si viene un user_id en POST o en  GET se obtiene los chats y los mensajes  
  
  if user_id:
    try:
        #destino = User.objects.get(id=user_id)
        #chat, mensajes = obtener_chats_mensajes(request.user, destino) #se llama a la función obtener chat( usuario inicial = request.user(usuario logeado),destino= obtener otro user)  
        destino = User.objects.get(id=user_id)
           # buscar chat en ambas direcciones
        chat = chat_privado.objects.filter(
            usuario1=request.user,
            usuario2=destino
        ).first() or chat_privado.objects.filter(
            usuario1=destino,
            usuario2=request.user
        ).first()
        # si no existe, crearlo
        if not chat:
            chat = chat_privado.objects.create(
                usuario1=request.user,
                usuario2=destino
            )
        # obtener los mensajes
        mensajes = mensaje_privado.objects.filter(chat=chat).order_by("fecha_envio")
        abrir_chat = True
  
  
  
    except User.DoesNotExist:
        pass  # el chat no se muestra si el id no existe
    
  #abrir_chat = True if destino else False # abrir_chat = True si hay destino (sirve para reabrir offcanvas en el template) 

  return render(request, "Intranets/admin.html", {"contactos": contactos,"chat": chat,"mensajes": mensajes,"destino": destino,"abrir_chat": abrir_chat})

@login_required()
@role_required(["Auditor"])
def auditor(request):
  contactos = lista_contactos(request)
  buscar = request.GET.get("buscar")
  if buscar:
      contactos = contactos.filter(email__icontains=buscar)

  chat = None
  abrir_chat = False
  mensajes = None
  destino = None
  user_id = request.POST.get("user_id") or request.GET.get("user_id") #  si viene un user_id en POST o en  GET se obtiene los chats y los mensajes 
  
  if user_id:
    try:
        #destino = User.objects.get(id=user_id)
        #chat, mensajes = obtener_chats_mensajes(request.user, destino) #se llama a la función obtener chat( usuario inicial = request.user(usuario logeado),destino= obtener otro user)    
        destino = User.objects.get(id=user_id)
           # buscar chat en ambas direcciones
        chat = chat_privado.objects.filter(
            usuario1=request.user,
            usuario2=destino
        ).first() or chat_privado.objects.filter(
            usuario1=destino,
            usuario2=request.user
        ).first()
        # si no existe, crearlo
        if not chat:
            chat = chat_privado.objects.create(
                usuario1=request.user,
                usuario2=destino
            )
        # obtener los mensajes
        mensajes = mensaje_privado.objects.filter(chat=chat).order_by("fecha_envio")
        abrir_chat = True
    
    except User.DoesNotExist:
        pass  # el chat no se muestra si el id no existe
    
  #abrir_chat = True if destino else False # abrir_chat = True si hay destino (sirve para reabrir offcanvas en el template) 

  return render(request, "Intranets/auditor.html", {"contactos": contactos,"chat": chat,"mensajes": mensajes,"destino": destino,"abrir_chat": abrir_chat})

@login_required()
@role_required(["Corredor"])
def corredor(request):
  contactos = lista_contactos(request)
  buscar = request.GET.get("buscar")
  if buscar:
      contactos = contactos.filter(email__icontains=buscar)

  chat = None
  abrir_chat = False
  mensajes = None
  destino = None
  
  user_id = request.POST.get("user_id") or request.GET.get("user_id") #  si viene un user_id en POST o en  GET se obtiene los chats y los mensajes 
  
  if user_id:
    try:
        #destino = User.objects.get(id=user_id)
        #chat, mensajes = obtener_chats_mensajes(request.user, destino) #se llama a la función obtener chat( usuario inicial = request.user(usuario logeado),destino= obtener otro user)    
        destino = User.objects.get(id=user_id)
           # buscar chat en ambas direcciones
        chat = chat_privado.objects.filter(
            usuario1=request.user,
            usuario2=destino
        ).first() or chat_privado.objects.filter(
            usuario1=destino,
            usuario2=request.user
        ).first()
        # si no existe, crearlo
        if not chat:
            chat = chat_privado.objects.create(
                usuario1=request.user,
                usuario2=destino
            )
        # obtener los mensajes
        mensajes = mensaje_privado.objects.filter(chat=chat).order_by("fecha_envio")
        abrir_chat = True
    
    
    except User.DoesNotExist:
        pass  # el chat no se muestra si el id no existe
    
  #abrir_chat = True if destino else False # abrir_chat = True si hay destino (sirve para reabrir offcanvas en el template) 

  return render(request, "Intranets/corredor.html", {"contactos": contactos,"chat": chat,"mensajes": mensajes,"destino": destino,"abrir_chat": abrir_chat})

@login_required()
@role_required(["Cliente"])
def cliente_dashboard(request):
  contactos = lista_contactos(request)
  buscar = request.GET.get("buscar")
  if buscar:
      contactos = contactos.filter(email__icontains=buscar)

  chat = None
  abrir_chat = False
  mensajes = None
  destino = None
  user_id = request.POST.get("user_id") or request.GET.get("user_id")
  
  if user_id:
    try:
        destino = User.objects.get(id=user_id)
        chat = chat_privado.objects.filter(
            usuario1=request.user,
            usuario2=destino
        ).first() or chat_privado.objects.filter(
            usuario1=destino,
            usuario2=request.user
        ).first()
        if not chat:
            chat = chat_privado.objects.create(
                usuario1=request.user,
                usuario2=destino
            )
        mensajes = mensaje_privado.objects.filter(chat=chat).order_by("fecha_envio")
        abrir_chat = True
    except User.DoesNotExist:
        pass

  return render(request, "Intranets/cliente.html", {"contactos": contactos,"chat": chat,"mensajes": mensajes,"destino": destino,"abrir_chat": abrir_chat})

###### CALIFICACIONES

@login_required()
@role_required(["Administrador", "Corredor"])
def crear_calificacion(request):

    categorias_niveladas = build_categorias_niveladas()

    # Factores sin categoría
    factores_sueltos = factor_calificacion.objects.filter(categoria__isnull=True)

    if request.method == 'POST':
      form = CalificacionTributariaForm(request.POST)
      if form.is_valid():
        calificacion = form.save(commit=False)

        if request.user.groups.filter(name="Corredor").exists():
            calificacion.origen_calificacion = "CORREDOR"
        elif request.user.groups.filter(name="Bolsa").exists():
          calificacion.origen_calificacion = "BOLSA"
        else: 
          calificacion.origen_calificacion = "SISTEMA"
        
        calificacion.estado = "PENDIENTE"
        
        # Guardar
        if "ingresar" in request.POST:
          calificacion.isfut = form.cleaned_data["isfut"]
          calificacion.factor_actualizacion = 0
          calificacion.dividendo = form.cleaned_data["dividendo"]
          calificacion.save()
          registrar_auditoria(request.user, instancia_despues=calificacion, accion="CREAR", descripcion="Ingreso de Calificación Tributaria")
          for f in factor_calificacion.objects.all():
            valor = form.cleaned_data.get(f"factor" + str(f.factor_id))
            if valor not in [None, ""]:
              update_or_create_with_auditoria(
          	    usuario=request.user,
          	    model_class=califica,
          	    lookup={"calificacion": calificacion, "factor": f},
          	    defaults={"valor": valor},
          	    descripcion_crear=f"Califica creado para factor {f.factor_id}",
          	  	descripcion_editar=f"Califica editado para factor {f.factor_id}",
							)

          return redirect('ver_calificaciones')
        # Calcular
        elif "calcular" in request.POST:

          valores_dict = {}
          for f in factor_calificacion.objects.all():
              raw = form.cleaned_data.get(f"factor" + str(f.factor_id), 0)
              try:
                  valores_dict[f.factor_id] = float(raw)
              except:
                  valores_dict[f.factor_id] = 0

          total_ids = list(range(8, 20))

          valores_calculados = calcular_factores(valores_dict, total_ids)

          updated = form.data.copy()

          for fid, valor in valores_calculados.items():
              updated.setlist(f"factor{fid}", [str(valor)])

          updated.setlist("ingreso_montos", ["False"])

          factores_sueltos_data = [
              {"obj": factor, "valor": valores_calculados[factor.factor_id]}
              for factor in factores_sueltos
          ]

          categorias_niveladas = build_categorias_niveladas(valores_calculados)

          form = CalificacionTributariaForm(updated)

          return render(request, "Creates/calificaciones.html", {
              "form_calificacion": form,
              "alert": "Factores calculados correctamente.",
              "categorias_niveladas": categorias_niveladas,
              "factores_sueltos": factores_sueltos_data,
          })

    # GET normal
    return render(request, 'Creates/calificaciones.html', {
        "form_calificacion": CalificacionTributariaForm(),
        "categorias_niveladas": categorias_niveladas,
        "factores_sueltos": [
        {"obj": f, "valor": 0} for f in factores_sueltos
    ],
    })

@login_required()
@role_required(["Administrador", "Corredor", "Auditor"])
def ver_calificaciones(request):
    calificaciones = calificacion_tributaria.objects.prefetch_related('califica_set__factor')

    mercado = request.GET.get("mercado")
    origen = request.GET.get("origen")
    anio = request.GET.get("anio")

    filtros = []
    if mercado:
        calificaciones = calificaciones.filter(mercado=mercado)
    if origen:
        calificaciones = calificaciones.filter(origen_calificacion=origen)
    if anio:
        calificaciones = calificaciones.filter(anio=anio)

    factores = factor_calificacion.objects.all().order_by("factor_id")
    id_factores = [factor.factor_id for factor in factores]
    datos = []
    for cal in calificaciones:
        valores = [c.valor for c in cal.califica_set.all().order_by("factor__factor_id")]
        datos.append({
            "obj": cal,      
            "valores": valores 
        })

    return render(request, "Readers/calificaciones.html", {
        "calificaciones": datos,
        "factores": factores,
        "factores_id": id_factores
    })

@login_required()
@role_required(["Cliente"])
def cliente_calificaciones(request):
    calificaciones = calificacion_tributaria.objects.filter(cliente=request.user).prefetch_related('califica_set__factor')

    factores = factor_calificacion.objects.all().order_by("factor_id")
    id_factores = [factor.factor_id for factor in factores]
    datos = []
    for cal in calificaciones:
        valores = [c.valor for c in cal.califica_set.all().order_by("factor__factor_id")]
        datos.append({
            "obj": cal,      
            "valores": valores 
        })

    return render(request, "Readers/cliente_calificaciones.html", {
        "calificaciones": datos,
        "factores": factores,
        "factores_id": id_factores
    })

@login_required()
@role_required(["Administrador", "Corredor", "Bolsa"])
def carga_por_monto(request):
    factores = factor_calificacion.objects.all().order_by("factor_id")

    
    if request.method == "GET":
        datos = request.session.get("carga_monto", None)
        return render(request, "Creates/Carga/por_monto.html", {
            "factores": factores,
            "datos": datos
        })

    if "archivo" in request.FILES:
        archivo = request.FILES["archivo"]
        contenido = archivo.read().decode("utf-8")
        lector = csvr(contenido.splitlines())

        filas = []
        for row in lector:
            # convertir factores automáticamente según la BD
            factores_row = []
            for f in factores:
                val = row.get(f"F{f.factor_id}", "0")
                try:
                    factores_row.append(float(val))
                except:
                    factores_row.append(0.0)

            filas.append({
                "anio": row.get("Ejercicio", ""),
                "mercado": row.get("Mercado", ""),
                "instrumento": row.get("Instrumento", ""),
                "fecha_pago": row.get("Fecha_Pago", ""),
                "descripcion": row.get("Descripcion", ""),
                "secuencia_evento": row.get("Secuencia_Evento", ""),
                "dividendo": row.get("Dividendo", ""),
                "valor_historico": row.get("Valor_Historico", ""),
                "factores": factores_row
            })

        # guardar en sesión
        request.session["carga_monto"] = filas
        request.session.modified = True

    # POST → CALCULAR
    if "calcular" in request.POST:
        filas = request.session.get("carga_monto", [])
        factores_total = list(range(8, 20))

        for fila in filas:
            valores_dict = {
                factores[i].factor_id: fila["factores"][i]
                for i in range(len(factores))
            }

            resultado = calcular_factores(valores_dict, factores_total)

            fila["factores"] = [
                resultado[f.factor_id] for f in factores
            ]

        request.session["carga_monto"] = filas
        
        return render(request, "Creates/Carga/por_monto.html", {
          "factores": factores,
          "datos": filas,
        })


    # POST → GRABAR
    if "grabar" in request.POST:
      filas = request.session.get("carga_monto", [])
      factores_total = list(range(8, 20))
      for fila in filas:
          valores_dict = {
              factores[i].factor_id: fila["factores"][i]
              for i in range(len(factores))
          }
          resultado = calcular_factores(valores_dict, factores_total)
          fila["factores"] = [
              resultado[f.factor_id] for f in factores
          ]
      
      user_group = None
      if request.user.groups.exists():
          user_group = request.user.groups.first().name.upper()
      
      origen = "SISTEMA"
      if user_group == "CORREDOR":
          origen = "CORREDOR"
      elif user_group == "BOLSA":
          origen = "BOLSA"
      
      for fila in filas:
          inst = instrumento_financiero.objects.filter(
              codigo__iexact=fila["instrumento"]
          ).first()
          if not inst:
              continue
                
          # 1) Buscar existente por secuencia
          cal = calificacion_tributaria.objects.filter(
              secuencia_evento=fila["secuencia_evento"]
          ).first()
      
          if cal:
              antes = cal
              # UPDATE
              cal.anio = fila["anio"]
              cal.mercado = fila["mercado"]
              cal.instrumento = inst
              cal.fecha_pago = fila["fecha_pago"]
              cal.descripcion = fila["descripcion"]
              cal.dividendo = fila["dividendo"]
              cal.valor_historico = fila["valor_historico"]
              cal.estado="PENDIENTE"
              cal.origen_calificacion = origen
              cal.save()
              registrar_auditoria(request.user, "EDITAR", "Calificación tributaria modificada via Carga Masiva.", instancia_antes=antes, instancia_despues=cal)
          else:
              # CREATE
              cal = calificacion_tributaria.objects.create(
                  anio=fila["anio"],
                  mercado=fila["mercado"],
                  instrumento=inst,
                  fecha_pago=fila["fecha_pago"],
                  descripcion=fila["descripcion"],
                  secuencia_evento=fila["secuencia_evento"],
                  dividendo=fila["dividendo"],
                  valor_historico=fila["valor_historico"],
                  estado="PENDIENTE",
                  origen_calificacion=origen,
                  isfut=False
              )
              registrar_auditoria(request.user, "CREAR", "Calificación tributaria ingresada via Carga Masiva.", instancia_despues=cal)
      
          # FACTORES
          print(fila["factores"][8])
          for i, f in enumerate(factores):
              update_or_create_with_auditoria(
          	    usuario=request.user,
          	    model_class=califica,
          	    lookup={"calificacion": cal, "factor": f},
          	    defaults={"valor": fila["factores"][i]},
          	    descripcion_crear=f"Califica creado para factor {f.factor_id} via carga masiva.",
          	  	descripcion_editar=f"Califica editado para factor {f.factor_id} via carga masiva.",
							)

    if "carga_monto" in request.session:
        del request.session["carga_monto"]

    return redirect("ver_calificaciones")

@login_required()
@role_required(["Administrador", "Corredor", "Bolsa"])
def carga_por_factor(request):
    factores = factor_calificacion.objects.all().order_by("factor_id")

    
    if request.method == "GET":
        datos = request.session.get("carga_factor", None)
        return render(request, "Creates/Carga/por_factor.html", {
            "factores": factores,
            "datos": datos
        })
    if "archivo" in request.FILES:
        archivo = request.FILES["archivo"]
        contenido = archivo.read().decode("utf-8")
        lector = csvr(contenido.splitlines())

        filas = []
        for row in lector:
            # convertir factores automáticamente según la BD
            factores_row = []
            for f in factores:
                val = row.get(f"F{f.factor_id}", "0")
                try:
                    factores_row.append(float(val))
                except:
                    factores_row.append(0.0)

            filas.append({
                "anio": row.get("Ejercicio", ""),
                "mercado": row.get("Mercado", ""),
                "instrumento": row.get("Instrumento", ""),
                "fecha_pago": row.get("Fecha_Pago", ""),
                "descripcion": row.get("Descripcion", ""),
                "secuencia_evento": row.get("Secuencia_Evento", ""),
                "dividendo": row.get("Dividendo", ""),
                "valor_historico": row.get("Valor_Historico", ""),
                "factores": factores_row
            })

        # guardar en sesión
        request.session["carga_factor"] = filas
        request.session.modified = True

    # POST → GRABAR
    if "grabar" in request.POST:
      filas = request.session.get("carga_factor", [])
      
      user_group = None
      if request.user.groups.exists():
          user_group = request.user.groups.first().name.upper()
      
      origen = "SISTEMA"
      if user_group == "CORREDOR":
          origen = "CORREDOR"
      elif user_group == "BOLSA":
          origen = "BOLSA"
      
      for fila in filas:
          inst = instrumento_financiero.objects.filter(
              codigo__iexact=fila["instrumento"]
          ).first()
          if not inst:
              continue
                
          # 1) Buscar existente por secuencia
          cal = calificacion_tributaria.objects.filter(
              secuencia_evento=fila["secuencia_evento"]
          ).first()
      
          if cal:
              antes = cal
              # UPDATE
              cal.anio = fila["anio"]
              cal.mercado = fila["mercado"]
              cal.instrumento = inst
              cal.fecha_pago = fila["fecha_pago"]
              cal.descripcion = fila["descripcion"]
              cal.dividendo = fila["dividendo"]
              cal.valor_historico = fila["valor_historico"]
              cal.estado="PENDIENTE"
              cal.origen_calificacion = origen
              cal.save()
              registrar_auditoria(request.user, "EDITAR", "Calificación tributaria modificada via Carga Masiva.", instancia_antes=antes, instancia_despues=cal)
          else:
              # CREATE
              cal = calificacion_tributaria.objects.create(
                  anio=fila["anio"],
                  mercado=fila["mercado"],
                  instrumento=inst,
                  fecha_pago=fila["fecha_pago"],
                  descripcion=fila["descripcion"],
                  secuencia_evento=fila["secuencia_evento"],
                  dividendo=fila["dividendo"],
                  valor_historico=fila["valor_historico"],
                  estado="PENDIENTE",
                  origen_calificacion=origen,
                  isfut=False
              )
              registrar_auditoria(request.user, "CREAR", "Calificación tributaria ingresada via Carga Masiva.", instancia_despues=cal)
      
          # FACTORES
          for i, f in enumerate(factores):
              update_or_create_with_auditoria(
          	    usuario=request.user,
          	    model_class=califica,
          	    lookup={"calificacion": cal, "factor": f},
          	    defaults={"valor": fila["factores"][i]},
          	    descripcion_crear=f"Califica creado para factor {f.factor_id} via carga masiva.",
          	  	descripcion_editar=f"Califica editado para factor {f.factor_id} via carga masiva.",
							)

    if "carga_monto" in request.session:
        del request.session["carga_factor"]

    return redirect("ver_calificaciones")

@login_required()
@role_required(["Administrador", "Corredor"])
def editar_calificacion(request, cal_id):
    calificacion = calificacion_tributaria.objects.get(pk=cal_id)

    # Valores existentes en factor_calificación
    valores_existentes = {
        c.factor.factor_id: c.valor
        for c in calificacion.califica_set.all()
    }

    if request.method == "POST":
        form = CalificacionTributariaForm(request.POST, instance=calificacion)
        if form.is_valid():
            calificacion = form.save(commit=False)
            calificacion.estado = "PENDIENTE"
            calificacion.save()
            registrar_auditoria(request.user, instancia_despues=calificacion, accion="EDITAR", descripcion="Modificación de Calificación Tributaria")
            for f in factor_calificacion.objects.all():
                valor = form.cleaned_data.get(f"factor" + str(f.factor_id)) or 0
                try:
                    existed = califica.objects.get(calificacion=calificacion, factor=f)
                    antes = existed
                except califica.DoesNotExist:
                    existed = None
                    antes = None
                obj, created = califica.objects.update_or_create(
                    calificacion=calificacion,
                    factor=f,
                    defaults={"valor": valor},
                )
                if created:
                    registrar_auditoria(
                        usuario=request.user,
                        instancia_antes=None,
                        instancia_despues=obj,
                        accion="CREAR",
                        descripcion=f"Califica creada para factor {f.factor_id}"
                    )
                else:
                    despues = obj
                    registrar_auditoria(
                        usuario=request.user,
                        instancia_antes=antes,
                        instancia_despues=despues,
                        accion="EDITAR",
                        descripcion=f"Actualización del factor {f.factor_id}"
                    )
            return redirect("ver_calificaciones")
    else:
        # Inicializamos valores en el form
        inicial = {
            f"factor{fid}": valor
            for fid, valor in valores_existentes.items()
        }
        form = CalificacionTributariaForm(instance=calificacion, initial=inicial)

    return render(request, "Creates/calificaciones.html", {
        "form_calificacion": form,
        "categorias_niveladas": build_categorias_niveladas(valores_existentes),
        "factores_sueltos": build_factores_sueltos(valores_existentes),
    })

@login_required()
@role_required(["Administrador", "Corredor"])
def eliminar_calificacion(request, cal_id):
  calificacion = calificacion_tributaria.objects.get(pk = cal_id)
  registrar_auditoria(request.user, instancia_antes=calificacion, accion="ELIMINAR", descripcion="Eliminación de Calificación Tributaria")
  calificacion.delete()
  return redirect('ver_calificaciones')

@login_required()
@role_required(["Administrador", "Auditor"])
def validar_calificacion(request):
    if request.method == 'GET':
        return render(request, 'Validators/calificaciones.html')

    else:
        calificacion_id = request.POST.get('seleccion')
        nuevo_estado = request.POST['accion']

        if calificacion_id is None:
            return render(request, 'Validators/calificaciones.html', {
                'msg': 'Debe seleccionar una calificación antes de validar o rechazar.'
            })

        try:
            calificacion = calificacion_tributaria.objects.get(pk=calificacion_id)
        except calificacion_tributaria.DoesNotExist:
            return render(request, 'validador.html', {
                'msg': 'La calificación seleccionada no existe.'
            })

        calificacion.estado = nuevo_estado
        calificacion.save()

        return render(request, 'Validators/calificaciones.html', {'msg': f'Calificación actualizada correctamente a: {nuevo_estado}.'})

###### INSTRUMENTOS

@login_required()
@role_required(["Administrador", "Auditor"])
def ver_instrumentos(request):
    instrumentos = instrumento_financiero.objects.all()


    if request.method == "POST":
        form = formInstrumentoFinanciero(request.POST)
        if 'buscar' in request.POST:
            instrumento_id = request.POST.get('instrumento_id', '')
            codigo = request.POST.get('codigo', '')
            descripcion = request.POST.get('descripcion','')
            categoria = request.POST.get('categoria', '')
            bolsa = request.POST.get('bolsa', '')
            mercado = request.POST.get('mercado', '')
            estado = request.POST.get('estado','')


            instrumentos = instrumento_financiero.objects.all()
            if instrumento_id:
                instrumentos = instrumentos.filter(instrumento_id = instrumento_id)
            if codigo:
                instrumentos = instrumentos.filter(codigo__icontains=codigo)
            if descripcion:
                instrumentos = instrumentos.filter(descripcion=descripcion)
            if categoria:
                instrumentos = instrumentos.filter(categoria=categoria)
            if bolsa:
                instrumentos = instrumentos.filter(bolsa=bolsa)
            if mercado:
                instrumentos = instrumentos.filter(mercado=mercado)
            if estado:
                instrumentos = instrumentos.filter(estado=estado)
    else:
      form = formInstrumentoFinanciero()


    return render(request, 'Readers/instrumentos.html', {'form': form,'instrumentos':instrumentos})

@login_required()
@role_required(["Cliente"])
def cliente_instrumentos(request):
    instrumentos = instrumento_financiero.objects.all()
    return render(request, 'Readers/cliente_instrumentos.html', {'instrumentos': instrumentos})

@login_required()
@role_required(["Cliente"])
def cliente_factores(request):
    factores = factor_calificacion.objects.all().order_by("factor_id")
    return render(request, 'Readers/cliente_factores.html', {'factores': factores})

@login_required()
@role_required(["Cliente"])
def cliente_agregar_solicitud(request):
    if request.method == "POST":
        form = formSolicitudCliente(request.user, request.POST)
        if form.is_valid():
            nueva_solicitud = form.save(commit=False)
            nueva_solicitud.usuario = request.user
            nueva_solicitud.group = request.user.groups.first()
            nueva_solicitud.save()
            return redirect('cliente_dashboard')
    else:
        form = formSolicitudCliente(cliente=request.user)
    return render(request, 'Creates/solicitud_cliente.html', {'form': form})

@login_required()
@role_required(["Administrador", "Auditor"])
def eliminar_instrumento(request, instrumento_id):
    instrumento = instrumento_financiero.objects.get(instrumento_id = instrumento_id)
    registrar_auditoria(request.user, instancia_antes=instrumento, accion="ELIMINAR", descripcion="Eliminación de Instrumento Financiero")
    instrumento.delete()
    return redirect('ver_instrumentos')

@login_required()
@role_required(["Administrador", "Auditor", "Corredor"])
def agregar_instrumento(request):
  #form = formInstrumentoFinanciero()
  if request.method == 'POST':
    form = formInstrumentoFinanciero(request.POST)  # toma los datos rellenados correctamente
    if form.is_valid():   # valida los datos limpios
      #form.save()
      inst = instrumento_financiero.objects.create(
        codigo=form.cleaned_data['codigo'],
        descripcion=form.cleaned_data['descripcion'],
        categoria=form.cleaned_data['categoria'],
        bolsa=form.cleaned_data['bolsa'],
        mercado=form.cleaned_data['mercado'],
        estado='Ingresado'
      )
      registrar_auditoria(request.user, instancia_despues=inst, accion="CREAR", descripcion="Ingreso de Instrumento Financiero")
      #inst.save()
      return redirect('ver_instrumentos')
  else:
    form = formInstrumentoFinanciero()
  data = {'form' : form}
  return render(request, 'Creates/instrumentos.html', data)
  
@login_required()
@role_required(["Administrador", "Auditor"])
def editar_instrumento(request, instrumento_id):
    instrumento = instrumento_financiero.objects.get(instrumento_id = instrumento_id)
    #form = formInstrumentoFinanciero(request.POST)
    if request.method == 'POST':
        form = formInstrumentoFinanciero(request.POST)
        if form.is_valid():
        # modelsform tiene variables distintas, instance no pescaria, ya que estamos usando el form
          antes = instrumento
          instrumento.codigo      = form.cleaned_data['codigo']
          instrumento.descripcion = form.cleaned_data['descripcion']
          instrumento.categoria   = form.cleaned_data['categoria']
          instrumento.bolsa       = form.cleaned_data['bolsa']
          instrumento.mercado     = form.cleaned_data['mercado']
          instrumento.estado      = 'Ingresado'
          instrumento.save()
          despues = instrumento
          registrar_auditoria(request.user, instancia_antes=antes ,instancia_despues=despues, accion="EDITAR", descripcion="Modificacion de Instrumento Financiero")
          return redirect('ver_instrumentos')
    else:
      #form = formInstrumentoFinanciero()
      form = formInstrumentoFinanciero(initial={ # initial muestra los valores que ya estan establecidos, sino estuviera los campos se verian vacios reemplaza al instance, la accion es manual no automatica como instance
            "codigo": instrumento.codigo,
            "descripcion": instrumento.descripcion,
            "categoria": instrumento.categoria,
            "bolsa": instrumento.bolsa,
            "mercado": instrumento.mercado
        })

    return render(request, 'Creates/instrumentos.html', {'form': form,'instrumento':instrumento})

###### USUARIOS

@login_required()
@role_required(["Administrador"])
def ver_usuarios(request):
  usuarios = User.objects.exclude(is_superuser=True)

  nombre = request.GET.get('nombre')
  apellido = request.GET.get('apellido')
  correo = request.GET.get('correo')
  rol = request.GET.get('rol')

  if nombre:
      usuarios = usuarios.filter(first_name__icontains=nombre)
  if apellido:
      usuarios = usuarios.filter(last_name__icontains=apellido)
  if correo:
      usuarios = usuarios.filter(email__icontains=correo)
  if rol:
      usuarios = usuarios.filter(groups__name__icontains=rol)
  return render(request, 'Readers/usuarios.html', {'usuarios': usuarios})

@login_required()
@role_required(["Administrador"])
def crear_usuario(request):
  alert = ''
  if request.method == 'POST':
    nombre = request.POST.get('nombre')
    apellido = request.POST.get('apellido')
    correo = request.POST.get('correo')
    rol = request.POST.get('rol')
    password1 = request.POST.get('password1')
    password2 = request.POST.get('password2')
    if User.objects.filter(email=correo).exists():
      alert = "El correo ya está registrado."
      return render(request, 'Creates/usuarios.html', {'alert': alert})
    if password1 != password2:
      return render(request, 'Creates/usuarios.html', {'alert': 'Las contraseñas no coinciden'})
        
    usuario = User.objects.create_user(email=correo, password=password1, first_name=nombre, last_name=apellido)
    registrar_auditoria(request.user, instancia_despues=usuario, accion="CREAR", descripcion="Ingreso de Usuario")
    grupo, created = Group.objects.get_or_create(name=rol.capitalize())
    usuario.groups.add(grupo)
    alert = f'Usuario creado correctamente.'
  return render(request, 'Creates/usuarios.html', {'alert': alert})
  
@login_required()
@role_required(["Administrador"])
def modificar_usuario(request, user_id):
  alert = ''
  usuario = User.objects.filter(id=user_id).first()
  
  
  if usuario is None:
    return redirect('administracion_usuarios')
  
  initial_data = {
    "nombre": usuario.first_name,
    "apellido": usuario.last_name,
    "correo": usuario.email,
    "rol": usuario.groups.first().name if usuario.groups.exists() else '',
  }

  if request.method == 'POST':
    nombre = request.POST.get('nombre')
    apellido = request.POST.get('apellido')
    correo = request.POST.get('correo')
    rol = request.POST.get('rol')
    contraseña = request.POST.get('password')
    
    if User.objects.filter(email=correo).exclude(id=user_id).exists():
      alert = "El correo ya está en uso."
      return render(request, 'Creates/usuarios.html', {'usuario': usuario, 'alert': alert})
    
    antes = usuario
    usuario.first_name = nombre
    usuario.last_name = apellido
    usuario.email = correo
    
    if contraseña:
      usuario.set_password(contraseña)
    usuario.groups.clear()
    grupo, created = Group.objects.get_or_create(name=rol.capitalize())
    usuario.groups.add(grupo)
    usuario.save()
    despues = usuario
    registrar_auditoria(request.user, instancia_antes=antes, instancia_despues=despues, accion="EDITAR", descripcion="Modificación de Usuario")
    alert = f"Usuario {usuario.first_name} {usuario.last_name} modificado correctamente."
    
    initial_data = {
      'nombre': usuario.first_name,
      'apellido': usuario.last_name,
      'correo': usuario.email,
      'rol': usuario.groups.all()[0].name 
      if usuario.groups.exists() 
      else ''
    }
  return render(request, 'Creates/usuarios.html', {'usuario': usuario, 'initial': initial_data, 'alert': alert})

@login_required()
@role_required(["Administrador"])
def eliminar_usuario(request, user_id):
  usuario = User.objects.filter(id=user_id).first()
  if not usuario:
    return render(request, 'Creates/usuarios.html', {'msg': "Usuario no encontrado"})
  correo = usuario.email
  registrar_auditoria(request.user, instancia_antes=usuario, accion="ELIMINAR", descripcion="Eliminación de Usuario")
  usuario.delete()
  msg = f"Usuario {correo} eliminado correctamente."
  return redirect('administracion_usuarios')

########## SOLICITUDES Y NOTIFICACIONES

@login_required()
@role_required(["Administrador", "Auditor"])
def gestion_solicitudes(request):
    contactos = lista_contactos(request)

    solicitud_id = request.GET.get('solicitud_id')
    usuario = request.GET.get('usuario')
    rol = request.GET.get('rol')
    motivo = request.GET.get('motivo')
    fecha = request.GET.get('fecha')

    solicitudes = solicitud.objects.all()

    if solicitud_id:
        solicitudes = solicitudes.filter(solicitud_id__icontains=solicitud_id)

    if usuario:
        solicitudes = solicitudes.filter(
            Q(usuario__first_name__icontains=usuario) |
            Q(usuario__last_name__icontains=usuario) |
            Q(usuario__email__icontains=usuario)
        )

    if rol:
        solicitudes = solicitudes.filter(group__name__icontains=rol)

    if motivo:
        solicitudes = solicitudes.filter(motivo__icontains=motivo)

    if fecha:
        solicitudes = solicitudes.filter(fecha__icontains=fecha)

    return render(request, 'Readers/solicitudes.html', {
        'solicitudes': solicitudes,
        'contactos': contactos
    })

@login_required()
@role_required(["Corredor", "Auditor", "Administrador"])
def agregar_solicitud(request):
    grupos = Group.objects.all()

    if request.method == "POST":
        form = formSolicitud(request.POST)

        if form.is_valid():
            group_id = request.POST.get("group")

            if not group_id:
                messages.error(request, "Debe seleccionar un rol destino.")
                return redirect("gestion_solicitudes")

            grupo_destino = get_object_or_404(Group, id=group_id)

            solicitud.objects.create(
                usuario=request.user,        
                group=grupo_destino,  
                motivo=form.cleaned_data["motivo"], 
            )

            messages.success(request, "Solicitud creada correctamente.")
            return redirect("gestion_solicitudes")

    else:
        form = formSolicitud(initial={"usuario_display": request.user.email})

    return render(request, "Creates/solicitudes.html", {"form": form, "grupos": grupos,})
  
@login_required()
@role_required(["Administrador", "Auditor", "Corredor"])
def editar_solicitud(request, solicitud_id):
  try:
    solic = solicitud.objects.get(solicitud_id=solicitud_id)
  except:
    return redirect("gestion_solicitudes")

  if request.method == "POST":
    form = formSolicitud(request.POST, instance=solic)
    if form.is_valid():
      form.save()
      return redirect("gestion_solicitudes")
  else:
    form = formSolicitud(instance=solic)

  return render(request, "Creates/solicitudes.html", {"form": form, "solicitud": solic})

@login_required()
@role_required(["Administrador", "Auditor", "Corredor"])
def eliminar_solicitud(request, solicitud_id):
    try:
        solic = solicitud.objects.get(solicitud_id=solicitud_id)
        solic.delete()
        messages.success(request, "Solicitud eliminada correctamente.")
    except:
        messages.error(request, "No se puede eliminar la solicitud porque está vinculada a otros registros.")
    return redirect('gestion_solicitudes')

@login_required
def panel_flotante(request):
    noti = notification.objects.filter(receptor=request.user)
    return render(request, "Readers/notificaciones.html", {"notifs": noti})

@login_required
def marcar_leida(request, noti_id):
    n = get_object_or_404(notification, id=noti_id, receptor=request.user)
    n.leida = True
    n.save()
    count = notification.objects.filter(receptor=request.user, leida=False).count()

    return render(request, "Readers/notificaciones.html", {
        "n": n,
        "count": count
    })

@login_required
@require_POST
def eliminar_notificacion(request, noti_id):
    noti = get_object_or_404(notification, id=noti_id, receptor=request.user)
    noti.delete()
    return HttpResponse("")

def actualizar_contador(request):
    count = request.user.notification_set.filter(leida=False).count()
    return render(request, "Readers/contador_noti.html", {"count": count})

################################# chats usuarios uno a uno   ##########################################


###### si fuera una función lista contactos #######


######  si fuera una vista ##############
#@login_required()
#def lista_contactos(request):
#    try:
#        user_actual = User.objects.get(email=request.user.email)
#        print(user_actual)
#    except User.DoesNotExist:
#        user_actual = None
#
#    if user_actual:
#        rol_actual = user_actual.groups.first()  # o user_actual.rol según lo que tengas implementado
#        contactos = User.objects.filter(groups=rol_actual).exclude(id=user_actual.id)
#    else:
#        contactos = []
#
#    return render(request, "chat.html", {"contactos": contactos})


#####################    creación de función reutilizable como lista de contactos para los mensajes y el chat ####################


#@login_required()    aqui no va el decorador porque es una funcion auxiliar y no usa el (request)
def obtener_chats_mensajes(usuario_actual, usuario_destino): 
# entrega el chat entre los usuarios si existe y sino existe lo crea 

    chat = chat_privado.objects.filter(  usuario1=usuario_actual,usuario2=usuario_destino).first() # busca si el chat existe

    if not chat:
        chat = chat_privado.objects.filter(usuario1=usuario_destino, usuario2=usuario_actual).first() # encuentra el chat aunque los usuarios esten invertidos

    if not chat:
        chat = chat_privado.objects.create(usuario1=usuario_actual,usuario2=usuario_destino)    # Si no existe el chat lo crea 

    mensajes = mensaje_privado.objects.filter(chat=chat).order_by("fecha_envio") # obtiene el mensaje ordenado por fecha de envio 

    return chat, mensajes



####################    mensaje privado uno a uno ###############################

@login_required()
def historial_mensaje_privado(request, user_id):    # usa user_id porque es el nombre que se le esta dando en la url  ya que en xampp solo sale id 
    contactos = lista_contactos(request) # funcion para el contacto con el offcanvas

    #usuario_actual = User.objects.get(email=request.user.email)     # verifica si el usuario existe
    usuario_actual = request.user
    try:                                                  # usa user_id porque es el nombre que se le esta dando en la url  ya que en xampp solo sale id 
        usuario_destino = User.objects.get(id=user_id)   # usuario receptor seleccionado por el id( id sale en xampp)
    except User.DoesNotExist:
        return redirect("intranet")

    
    chat = chat_privado.objects.filter(    # realiza la busqueda de una conversación entre ambos
        usuario1=usuario_actual,
        usuario2=usuario_destino
    ).first()

    if not chat:
        chat = chat_privado.objects.filter( usuario1=usuario_destino, usuario2=usuario_actual).first()

    if not chat:
        chat = chat_privado.objects.create(   # si el chat no existe se crea
            usuario1=usuario_actual,
            usuario2=usuario_destino
        )

    #mensajes = mensaje_privado.objects.filter(chat=chat).order_by("fecha_envio")  # solo en obtener mensaje, obtiene el mensaje ordenado por la fecha de envio

  #  return render(request, "panel_chat.html", {        #devuelve el cuerpo del mensaje 
  #      "chat": chat,
  #      "mensajes": mensajes,
  #      "contactos": contactos,
  #      "destino": usuario_destino,
  #  })

  # en vez de renderizar una página, redirige al panel principal
    if request.user.groups.filter(name="Administrador").exists():
        return redirect(f"/intranet/admin/?user_id={user_id}")

    if request.user.groups.filter(name="Auditor").exists():
        return redirect(f"/intranet/auditor/?user_id={user_id}")

    if request.user.groups.filter(name="Corredor").exists():
        return redirect(f"/intranet/corredor/?user_id={user_id}")

    # redirije al intranet para que no se caiga
    return redirect("intranet")
  




#####################################        enviar mensaje privado    #####################################


@login_required()
def enviar_mensaje_privado(request, chat_id):     # lo esta tomando del nombre de la bd: chat_id ( fk de la tabla chat_privado), y asi saber en cual id se guardara el chat
    
    if request.method != "POST":    # solo permite acceder a la vista si los datos ingresados en el formulario fue enviado por post
        return redirect("intranet")  # si se intentan acceder por la url no lo dejara y redirije a intranet 


    #usuario_actual = User.objects.get(email=request.user.email) # usario que esta enviando un mensaje, se usa el mail porque se identifica al usuario por el mail no por el nombre
    usuario_actual = request.user

    try:
        chat = chat_privado.objects.get(id=chat_id)     # se verifica que la ventana de chat ha sido creado o que existe 
    except chat_privado.DoesNotExist:
        return redirect("intranet")     # sino existe retorna a la intranet

    texto = request.POST.get("mensaje", "").strip()      # strip: limina el espacios iniciales y finales en el texto, el get obtiene el texto del formulario

    if texto != "":   # si texto no esta vacio, se crea un mensaje con model chat_privado(usuario 1,2 y fecha creación), usuario actual y mensaje 
        mensaje_privado.objects.create(
            chat=chat,
            usuario=usuario_actual,
            mensaje=texto
        )

    if chat.usuario1.id == usuario_actual.id:     # el usuario 1 es el usuario que esta usando la pagina en el momento actual 
        destino_id = chat.usuario2.id              # destino sera el usuario 2
    else:
        destino_id = chat.usuario1.id             # de otro modo si el usuario actual es el usuario 2, el destino sera el usuario 1
                                                                        # redirige al historial de la conversación con el otro usuario
    #return redirect("historial_mensaje_privado", user_id=destino_id)   # user_id representa el id del otro usuario en la conversación (el destino), y si el usuario actual es usuario2, el destino es usuario1
    #return redirect(f"/chat/historial/{destino_id}/")  # forma simple de derigir cuando hay parametros como el id seria = f"/url/{parametro}/"
    # forma mas profesional pero que no han pasado =  from django.urls import reverse ; return redirect(reverse("historial_mensaje_privado", kwargs={"user_id": destino_id}))

    # redirigir a la vista acorde al rol y se anexa a  ?user_id=destino_id
    if request.user.groups.filter(name="Administrador").exists():
        return redirect(f"/intranet/admin/?user_id={destino_id}")
    elif request.user.groups.filter(name="Auditor").exists():
        return redirect(f"/intranet/auditor/?user_id={destino_id}")
    else:
        return redirect(f"/intranet/corredor/?user_id={destino_id}")



## AUDITORIA

@login_required() 
@role_required(["Administrador", "Auditor"])

def historial_auditoria(request): 
  registros = Auditoria.objects.order_by("-fecha") 
  return render(request, "Readers/auditoria.html", { "auditorias": registros })

@login_required()
@role_required(["Administrador", "Auditor"])

@login_required
@role_required(["Administrador", "Auditor"])
def validar_instrumentos(request):
    estado = request.GET.get("estado", "")
    texto = request.GET.get("texto", "")
    instrumentos = instrumento_financiero.objects.all()

    if estado:
        instrumentos = instrumentos.filter(estado__iexact=estado)

    if texto:
        instrumentos = instrumentos.filter(
            Q(codigo__icontains=texto) |
            Q(descripcion__icontains=texto) |
            Q(categoria__icontains=texto) |
            Q(bolsa__icontains=texto)
        )

    if request.method == "POST":
        instrumento_id = request.POST.get("seleccion")
        accion = request.POST.get("accion")

        if instrumento_id:
            inst = instrumento_financiero.objects.get(pk=instrumento_id)
            inst.estado = accion
            inst.save()

        return redirect("validar_instrumentos")

    return render(request, "Readers/validar_instrumentos.html", {
        "instrumentos": instrumentos,
        "estado": estado,
        "texto": texto,
    })
    
@login_required
@role_required(["Administrador", "Auditor"])
def validar_calificaciones(request):

    estado = request.GET.get("estado", "")
    texto = request.GET.get("texto", "")
    calificaciones = calificacion_tributaria.objects.select_related("instrumento").all()
    
    if estado:
        calificaciones = calificaciones.filter(estado__iexact=estado)

    if texto:
        calificaciones = calificaciones.filter(
            Q(secuencia_evento__icontains=texto) |
            Q(descripcion__icontains=texto) |
            Q(instrumento__codigo__icontains=texto) |
            Q(instrumento__descripcion__icontains=texto)
        )

    if request.method == "POST":
        cal_id = request.POST.get("seleccion")
        accion = request.POST.get("accion")

        if cal_id:
            cal = calificacion_tributaria.objects.get(pk=cal_id)
            cal.estado = accion
            cal.save()

        return redirect("validar_calificaciones")

    return render(request, "Readers/validar_calificaciones.html", {
        "calificaciones": calificaciones,
        "estado": estado,
        "texto": texto,
    })
