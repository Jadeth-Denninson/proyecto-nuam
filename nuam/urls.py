"""
URL configuration for nuam project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from Intranet import views as intr

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', intr.index),
    path('login/', intr.VW_login, name='login'),
    path('logout/', intr.VW_logout, name="logout"),
    path('intranet/', intr.VW_intranet, name="intranet"),
    path('intranet/admin/', intr.admin, name="admin"),
    path('intranet/corredor/', intr.corredor, name="corredor"),
    path('intranet/auditor/', intr.auditor, name="auditor"),
    path('intranet/cliente/', intr.cliente_dashboard, name="cliente_dashboard"),
    path('cliente/calificaciones/', intr.cliente_calificaciones, name="cliente_calificaciones"),
    path('cliente/instrumentos/', intr.cliente_instrumentos, name="cliente_instrumentos"),
    path('cliente/factores/', intr.cliente_factores, name="cliente_factores"),
    path('cliente/solicitudes/crear/', intr.cliente_agregar_solicitud, name='cliente_agregar_solicitud'),
    path('solicitudes/', intr.gestion_solicitudes, name='gestion_solicitudes'),
    path('solicitudes/crear/', intr.agregar_solicitud, name='agregar_solicitud'),
    path('solicitudes/editar/<int:solicitud_id>', intr.editar_solicitud, name='editar_solicitud'),
    path('solicitudes/eliminar/<int:solicitud_id>', intr.eliminar_solicitud, name='eliminar_solicitud'),
    path("notificaciones/leida/<int:noti_id>/", intr.marcar_leida, name="marcar_leida"),
    path("notificaciones/panel/", intr.panel_flotante, name="panel_flotante"),
    path('notificaciones/eliminar/<int:noti_id>/', intr.eliminar_notificacion, name='eliminar_notificacion'),
    path('notificaciones/contador/', intr.actualizar_contador, name='actualizar_contador'),
    path('gestores/calificaciones/', intr.ver_calificaciones, name="ver_calificaciones"),
    path('gestores/calificaciones/nueva', intr.crear_calificacion, name="crear_calificacion"),
    path('gestores/calificaciones/editar/<int:cal_id>', intr.editar_calificacion, name="editar_calificacion"),
    path('gestores/calificaciones/eliminar/<int:cal_id>', intr.eliminar_calificacion, name="eliminar_calificacion"),
    path('gestores/calificaciones/carga/monto/', intr.carga_por_monto, name='carga_monto'),
    path('gestores/calificaciones/carga/factor/', intr.carga_por_factor, name='carga_factor'),
    path('gestores/instrumentos/', intr.ver_instrumentos, name='ver_instrumentos'),
    path('gestores/instrumentos/nueva', intr.agregar_instrumento, name='agregar_instrumento'),
    path('gestores/instrumentos/actualizar/<int:instrumento_id>', intr.editar_instrumento, name='actualizar_instrumento'),
    path('gestores/instrumentos/eliminar/<int:instrumento_id>', intr.eliminar_instrumento, name='eliminar_instrumento' ),
    path("gestores/auditoria", intr.historial_auditoria, name="auditoria"),
    path('validacion/calificaciones/', intr.validar_calificaciones, name="validar_calificaciones"),
    path('validacion/instrumentos/', intr.validar_instrumentos, name='validar_instrumentos'),
    path('usuarios/ver', intr.ver_usuarios, name='administracion_usuarios'),
    path('usuarios/crear/', intr.crear_usuario, name='crear_usuario'),
    path('usuarios/actualizar/<int:user_id>', intr.modificar_usuario, name='modificar_usuario'),
    path('usuarios/eliminar/<int:user_id>', intr.eliminar_usuario, name='eliminar_usuario'),
    path('chat/contactos/', intr.lista_contactos, name='lista_contactos'),
    path('chat/historial/<int:user_id>/', intr.historial_mensaje_privado, name='historial_mensaje_privado'),
    path('chat/enviar/<int:chat_id>/', intr.enviar_mensaje_privado, name='enviar_mensaje_privado'),
]

