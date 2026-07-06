# Guía de Configuración para Entornos en la Nube (AWS y Azure)

Una vez que hayas creado tus instancias en AWS RDS (para la base de datos MySQL) y Azure Cosmos DB (para el registro de eventos de auditoría), deberás reemplazar los datos en los siguientes archivos de tu proyecto Django.

---

## 1. Configuración de Azure Cosmos DB

El archivo responsable de enviar los eventos de auditoría, inicios y cierres de sesión a Cosmos DB es:
📍 `Intranet/cosmos_logger.py`

Deberás descomentar el código que está dentro de ese archivo y rellenar las siguientes variables con la información que te entregue Azure:

- **`URL`**: El Endpoint URI de tu cuenta de Cosmos DB.
  *(Ejemplo: `https://mi-cuenta-cosmos.documents.azure.com:443/`)*
- **`KEY`**: La clave primaria (Primary Key) de lectura/escritura de tu cuenta.
- **`DATABASE_NAME`**: El nombre de la base de datos que creaste dentro de Cosmos DB (ej. `AuditoriaDB`).
- **`CONTAINER_NAME`**: El nombre del contenedor (tabla) que creaste dentro de tu base de datos (ej. `Eventos`).

> **Nota:** Recuerda instalar la librería de Azure para Python en tu servidor cuando lo despliegues:
> `pip install azure-cosmos`

---

## 2. Configuración de AWS RDS (MySQL)

El archivo responsable de la conexión principal de la base de datos del proyecto es:
📍 `nuam/settings.py`

Dentro de este archivo, busca el diccionario `DATABASES`. Tendrás que configurarlo con los datos de tu RDS (o mejor aún, usar variables de entorno para que sea seguro):

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'nuamdb',                    # El nombre de la BD que creaste con el script poner_en_sql.sql
        'USER': 'django_user',               # El usuario que creaste (o el admin de la RDS)
        'PASSWORD': 'tu_contraseña_segura',  # La contraseña asignada
        'HOST': 'tu-instancia-rds.xxxxxx.us-east-1.rds.amazonaws.com',  # El Endpoint de tu RDS en AWS
        'PORT': '3306',                      # Puerto por defecto de MySQL
    }
}
```

- **`NAME`**: El nombre de la base de datos.
- **`USER`**: El usuario con el que te conectarás.
- **`PASSWORD`**: La contraseña del usuario.
- **`HOST`**: El Endpoint de tu base de datos que aparece en el panel de AWS RDS.
- **`PORT`**: 3306 (a menos que hayas elegido otro puerto en AWS).

> **Consejo de Seguridad:** Te recomiendo no escribir la contraseña y el host directamente en el archivo `settings.py` si vas a subir el código a GitHub. En su lugar, puedes usar librerías como `python-dotenv` para leer estos valores desde un archivo `.env` que se mantenga oculto.
