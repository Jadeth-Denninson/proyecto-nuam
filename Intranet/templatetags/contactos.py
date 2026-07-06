from django import template
from Intranet.views import lista_contactos

register = template.Library()

@register.simple_tag(takes_context=True)
def obtener_contactos(context):
    request = context["request"]
    return lista_contactos(request)
