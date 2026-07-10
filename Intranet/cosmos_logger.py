from django.conf import settings
from azure.cosmos import CosmosClient
from datetime import datetime
import uuid

client = CosmosClient(
    settings.COSMOS_ENDPOINT,
    credential=settings.COSMOS_KEY
)

database = client.get_database_client(
    settings.COSMOS_DATABASE
)

container = database.get_container_client(
    settings.COSMOS_CONTAINER
)

def log_event_to_cosmos(evento, usuario, detalles=None):
    try:
        item = {
            "id": str(uuid.uuid4()),
            "evento": evento,
            "usuario": usuario,
            "detalles": detalles,
            "fecha_registro": datetime.utcnow().isoformat()
        }
        
        container.create_item(body=item)
    except Exception as e:
        print(f"Error al registrar en Cosmos DB: {e}")
    print(f"[COSMOS DB STUB] Evento: {evento} | Usuario: {usuario} | Detalles: {detalles}")
