# Básico

## Instalar dependencias

`pip install django`
`pip install pymysql`

## Actualizar MariaDB

1. Descargar versiones más actualizadas de MariaDB en formato ZIP
2. Descomprimir carpeta `mariadb-version*` y cambiar su nombre a `mysql`
3. Cambiar nombre de carpeta `mysql` a `mysql_old` en la carpeta `C:/xampp`
4. Copiar carpeta de `mysql` (mariadb descomprimido) a `C:/xampp`
5. Abriendo tanto `mysql/` como `mysql_old/`, revisar las carpetas que tienen cada una
6. Copiar las carpetas `msql_old/data`, `msql_old/backup` y `msql_old/scripts` de `mysql_old` a `mysql`
7. Copiar archivos `msql_old/mysql_installservice`, `msql_old/mysql_uninstallservice`, `msql_old/resetroot` de `mysql_old` a `mysql`
8. Abrir carpeta `./bin` tanto en `mysql` como `mysql_old`.
9. Buscar archivo `msql_old/my` en `mysql_old` y copiarlo a `mysql`
10. Volver atrás, y entrar en la carpeta `./data`.
11. Borrar todos los archivos (excepto carpetas), de `mysql/data`.
12. Iniciar xampp.

## Crear proyecto:

`django-admin startproject nombre`

`cd nombre`

`code .`

## Ajustes (Settings) Básicos

```py
'''
Cambios marcados con "#" son cambios a líneas existentes
Cambios marcados con "#~!" son líneas completamente nuevas/que se agregan
'''

import os #~!
import pymysql #~!
pymysql.install_as_MySQLdb() #~!

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'nombre_carpeta_templates')], #
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', #
        'NAME': 'nombre_bd', #
        'USER': 'root', #~!
        'PASSWORD': '' #~!
    }
}

STATIC_URL = 'static/'
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'nombre_carpeta_static')] #~!

```

**Ojo! Recuerden crear, carpetas "nombre_carpeta_static" y "nombre_carpeta_templates" para que los cambios en settings funcionen!**
**Ojo! Recuerden crear la base de datos "nombre_bd" para que funcione el código de BD de settings!**

## Crear nuevas "Apps"

1. En terminal: `py manage.py startapp nombre_app`,
2. En settings.py:

```py
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'nombre_app', #~!
]
```

## CONSEJO

1. En los computadores de INACAP, por lo general no está instalada la extensión de Python, así que deben instalarla para ver las sugerencias de código.
2. Así mismo, podrían instalar adicionalmente la extensión Django Support (de alrededor de 40k de descargas), para ver recomendaciones de Django al trabajar con HTML. (Recomendaciones y Atajos para DTL, como  `{% for %}`, `{{ var }}`, etc.)
3. Si quieren ir un paso más allá, podrían buscar alguna extensión de Bootstrap 5, como "Bootstrap 5 Quick Snippets", que les permitirá escribir `bs5-` en html y acceder a templates/presets hechos de muchas funciones de bootstrap, sean cards, navbars, listas, etc.

