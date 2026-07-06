from .models import notification

def notificaciones_context(request):
    if request.user.is_authenticated:
        notifs = notification.objects.filter(receptor=request.user).order_by('-fecha')
        notifs_no_leidas = notifs.filter(leida=False)
        return {
            'notificaciones': notifs,
            'notificaciones_no_leidas': notifs_no_leidas,
            'notificaciones_no_leidas_count': notifs_no_leidas.count()
        }
    return {}