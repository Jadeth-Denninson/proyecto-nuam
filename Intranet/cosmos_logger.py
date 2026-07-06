"""
Módulo para registrar auditoría y eventos (como inicio/cierre de sesión y CRUD) en Azure Cosmos DB.
Esta es una plantilla lista para ser implementada con los credenciales reales.
"""

def log_event_to_cosmos(evento, usuario, detalles=None):
    """
    Función preparada para enviar eventos a Azure Cosmos DB.
    Debe rellenarse con la conexión real a Cosmos DB.
    
    :param evento: Tipo de evento (ej. 'INICIO_SESION', 'CIERRE_SESION', 'CREAR', 'EDITAR', 'ELIMINAR')
    :param usuario: Nombre o correo del usuario que realizó la acción
    :param detalles: Diccionario con detalles adicionales (ej. tabla modificada, valores)
    """
    # TODO: Instalar SDK de Azure (pip install azure-cosmos) y configurar credenciales
    # from azure.cosmos import CosmosClient, PartitionKey, exceptions
    
    # URL = "https://<tu-cuenta-cosmos>.documents.azure.com:443/"
    # KEY = "<tu-clave-primaria>"
    # DATABASE_NAME = "AuditoriaDB"
    # CONTAINER_NAME = "Eventos"
    
    # try:
    #     client = CosmosClient(URL, credential=KEY)
    #     database = client.get_database_client(DATABASE_NAME)
    #     container = database.get_container_client(CONTAINER_NAME)
    #     
    #     item = {
    #         "id": str(uuid.uuid4()),
    #         "evento": evento,
    #         "usuario": usuario,
    #         "detalles": detalles,
    #         "fecha_registro": datetime.utcnow().isoformat()
    #     }
    #     
    #     container.create_item(body=item)
    # except Exception as e:
    #     print(f"Error al registrar en Cosmos DB: {e}")
    
    # Placeholder de log en consola para propósitos de prueba
    print(f"[COSMOS DB STUB] Evento: {evento} | Usuario: {usuario} | Detalles: {detalles}")
