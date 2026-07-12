from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from django.contrib.auth import get_user_model
from .models import solicitud, notification

User = get_user_model()

def obtener_nombre_usuario(user):
    if not user:
        return "Usuario desconocido"

    if user.first_name or user.last_name:
        return f"{user.first_name} {user.last_name}".strip()

    if user.email:
        return user.email

    return str(user)

def notificar_grupo(grupo_obj, tipo, mensaje):
    if not grupo_obj:
        print("El grupo especificado no existe")
        return

    usuarios = grupo_obj.user_set.all()

    for user in usuarios:
        notification.objects.create(
            tipo=tipo,
            mensaje=mensaje,
            receptor=user
        )
        
##@receiver(post_save, sender=calificacion_tributaria)
##def cambios_calificacion(sender, instance, created, **kwargs):
##    if created:
##        notificar_adm(
##            "Calificacion Tributaria creada",
##            f"Calificación tributaria N° {instance.secuencia_evento} creada"
##        )
##    else:
##        notificar_adm(
##            "Calificacion Tributaria actualizada",
##            f"Calificación tributaria N° {instance.secuencia_evento} modificada"
##        )
##
##@receiver(post_delete, sender=calificacion_tributaria)
##def eliminar_calificacion(sender, instance, **kwargs):
##    notificar_adm(
##        "Calificacion Tributaria eliminada",
##        f"Calificación tributaria N° {instance.secuencia_evento} eliminada"
##    )
##
##@receiver(post_save, sender=instrumento_financiero)
##def cambios_instrumento(sender, instance, created, **kwargs):
##    if created:
##        notificar_adm(
##            "Instrumento Financiero creado",
##            f"Instrumento financiero N° {instance.instrumento_id} creado"
##        )
##    else:
##        notificar_adm(
##            "Instrumento Financiero actualizado",
##            f"Instrumento financiero N° {instance.instrumento_id} modificado"
##        )
##
##@receiver(post_delete, sender=instrumento_financiero)
##def eliminar_instrumento(sender, instance, **kwargs):
##    notificar_adm(
##        "Instrumento Financiero eliminado",
##        f"Instrumento financiero N° {instance.instrumento_id} eliminado"
##    )

@receiver(post_save, sender=solicitud)
def cambios_solicitud(sender, instance, created, **kwargs):
    nombre = obtener_nombre_usuario(instance.usuario)
    grupo_destino = instance.group

    if created:
        notificar_grupo(
            grupo_destino,
            "Solicitud creada",
            f"Solicitud N° {instance.solicitud_id} creada por {nombre}"
        )
    else:
        notificar_grupo(
            grupo_destino,
            "Solicitud actualizada",
            f"Solicitud N° {instance.solicitud_id} modificada por {nombre}"
        )

@receiver(post_delete, sender=solicitud)
def eliminar_solicitud(sender, instance, **kwargs):
    nombre = obtener_nombre_usuario(instance.usuario)
    grupo_destino = instance.group

    notificar_grupo(
        grupo_destino,
        "Solicitud eliminada",
        f"Solicitud N° {instance.solicitud_id} eliminada por {nombre}"
    )
    
##@receiver(post_save, sender=instrumento_financiero)
##def validar_instrumento(sender, instance, created, **kwargs):
##
##    if created:
##        return
##
##    old = instrumento_financiero.objects.get(pk=instance.pk)
##
##    if old.estado != instance.estado:
##        if instance.estado == "Validado":
##            notificar_adm("Instrumento validado",
##            f"Instrumento Financiero N° {instance.codigo} ha sido validado")
##
##        if instance.estado == "Rechazado":
##            notificar_adm("Instrumento rechazado",
##            f"Instrumento Financiero N° {instance.codigo} ha sido rechazado")
##            
##@receiver(post_save, sender=calificacion_tributaria)
##def validar_calificacion(sender, instance, created, **kwargs):
##    if created:
##        return
##
##    try:
##        old = calificacion_tributaria.objects.get(pk=instance.pk)
##    except calificacion_tributaria.DoesNotExist:
##        return
##
##    if old.estado == instance.estado:
##        return
##
##    if instance.estado == "VALIDADA":
##        notificar_adm(
##            "Calificación validada",
##            f"Calificación Tributaria N° {instance.secuencia_evento} ha sido validada"
##        )
##
##    elif instance.estado == "RECHAZADA":
##        notificar_adm(
##            "Calificación rechazada",
##            f"Calificación Tributaria N° {instance.secuencia_evento} ha sido rechazada"
##        )