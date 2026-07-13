from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager, Group

## Create your models here.

class UserManager(BaseUserManager):
    use_in_migrations = True

    def _create_user(self, email, password, **extra_fields):
        if not email:
            raise ValueError("El usuario debe tener un correo electrónico")
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", False)
        extra_fields.setdefault("is_superuser", False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError("Superuser debe tener is_staff=True.")
        if extra_fields.get("is_superuser") is not True:
            raise ValueError("Superuser debe tener is_superuser=True.")

        return self._create_user(email, password, **extra_fields)

class User(AbstractUser):
    username = None
    email = models.EmailField(unique=True)

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    objects = UserManager()

##### solicitud #####

class solicitud(models.Model):
    solicitud_id = models.AutoField(primary_key=True)
    usuario = models.ForeignKey(User, on_delete=models.CASCADE)
    group = models.ForeignKey(Group, on_delete=models.CASCADE)
    calificacion = models.ForeignKey('calificacion_tributaria', on_delete=models.CASCADE, null=True, blank=True, related_name='solicitudes')
    motivo = models.TextField()
    fecha = models.DateField(auto_now_add=True, null=True, blank=True)

    def str(self):
        return f"Solicitud {self.solicitud_id} de {self.usuario.username}"

#### notificacion ####

class notification(models.Model):
    class Meta:
        ordering = ['-fecha']
        
    tipos_notificacion = [
        ("calificacion_created", "Calificación creada"),
        ("calificacion_updated", "Calificación actualizada"),
        ("calificacion_deleted", "Calificación eliminada"),
        ("instrumento_created", "Instrumento creado"),
        ("instrumento_updated", "Instrumento actualizado"),
        ("instrumento_deleted", "Instrumento eliminado"),
        ("solicitud_creada", "Solicitud creada"),
    ]

    tipo = models.CharField(max_length=50, choices=tipos_notificacion)
    mensaje = models.TextField()
    fecha = models.DateTimeField(auto_now_add=True)
    leida = models.BooleanField(default=False)
    receptor = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.tipo} - {self.mensaje[:20]}"

##### instrumento financiero #####

class instrumento_financiero(models.Model):
    instrumento_id = models.AutoField(primary_key=True)
    codigo = models.CharField(max_length=6, unique=True)
    descripcion = models.CharField(max_length=150)
    categoria = models.CharField(max_length=50)
    bolsa = models.CharField(max_length=30)
    mercado = models.CharField(max_length=50)
    estado = models.CharField(max_length=9) # Auto-Field - Ingresado | Validado | Rechazado

    def __str__(self):
        return f"{self.codigo}{self.categoria}"

##### factor_calificacion #####

class categoria_factor(models.Model):
    nombre = models.CharField(max_length=200)
    padre = models.ForeignKey(
        'self',
        null=True,
        blank=True,
        on_delete=models.CASCADE
    )

class factor_calificacion(models.Model):
    factor_id = models.AutoField(primary_key=True, default=8)
    nombre_factor = models.CharField(max_length=120)
    categoria = models.ForeignKey(categoria_factor, null=True, on_delete=models.CASCADE)
    descripcion = models.TextField(null=True, blank=True, default='')
    def __str__(self):
        return self.nombre_factor

##### calificacion tributaria #####

MERCADOS = [
        ("ACCIONES", "Acciones"),
        ("RENTA FIJA", "Renta Fija"),
        ("DERIVADOS FINANCIEROS", "Derivados Financieros"),
        ("FONDOS DE INVERSIÓN-MUTUOS", "Fondos de Inversión-Mutuos"),
        ("INSTRUMENTOS DEL BANCO CENTRAL", "Instrumentos del Banco Central"),
        ("INSTRUMENTOS DEL ESTADO-TESORERÍA", "Instrumentos del Estado-Tesorería"),
        ("MERCADO MONETARIO", "Mercado Monetario"),
        ("MERCADO INTERNACIONAL", "Mercado Internacional"),
        ("MERCADO BANCARIO-CRÉDITOS", "Mercado Bancario-Créditos"),
    ]  

ORIGENES = [
    ("CORREDOR", "Corredor"),
    ("BOLSA", "Bolsa"),
    ("SISTEMA", "Sistema Interno"),
]

ESTADOS = [
    ("PENDIENTE", "Pendiente"),
    ("VALIDADA", "Validada"),
    ("RECHAZADA", "Rechazada"),
]

class calificacion_tributaria(models.Model):
    secuencia_evento = models.BigIntegerField(primary_key=True)

    mercado = models.CharField(max_length=50, choices=MERCADOS)
    instrumento = models.ForeignKey(instrumento_financiero, on_delete=models.CASCADE)
    cliente = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True, related_name='calificaciones_tributarias')
    descripcion = models.CharField(max_length=150)
    fecha_pago = models.DateField()
    dividendo = models.IntegerField(null=True, blank=True)
    valor_historico = models.BigIntegerField(null=True, blank=True)
    anio = models.IntegerField()
    estado = models.CharField(max_length=30, choices=ESTADOS)

    origen_calificacion = models.CharField(max_length=20, choices=ORIGENES, default="SISTEMA")

    isfut = models.BooleanField(default=False)
    factor_actualizacion = models.DecimalField(max_digits=10, decimal_places=6, default=0)
    evento_capital = models.IntegerField(null=True, blank=True)

    factores = models.ManyToManyField(factor_calificacion, through='califica')

    def __str__(self):
        return f"Calificación {self.secuencia_evento} — {self.descripcion}"



##### califica #####

class califica(models.Model):
    factor = models.ForeignKey(factor_calificacion, on_delete=models.CASCADE)
    calificacion = models.ForeignKey(calificacion_tributaria, on_delete=models.CASCADE)
    valor = models.FloatField(default=0.0)

    def __str__(self):
        return f"{self.factor}{self.calificacion} ({self.valor})"
    
############ chat privado uno a uno ##############

class chat_privado(models.Model):
    usuario1 = models.ForeignKey(User, related_name="privado_usuario1", on_delete=models.CASCADE)
    usuario2 = models.ForeignKey(User, related_name="privado_usuario2", on_delete=models.CASCADE)
    fecha_creacion = models.DateTimeField(auto_now_add=True) # Esto permite que  Django guardarde esa fecha y ya no se pueda cambiar

    def __str__(self):
        return f"Conversación entre {self.usuario1.username} y {self.usuario2.username}"

############ mensajes privados uno a uno ##############

class mensaje_privado(models.Model):
    chat = models.ForeignKey(chat_privado, on_delete=models.CASCADE)
    usuario = models.ForeignKey(User, on_delete=models.CASCADE)
    mensaje = models.TextField()
    fecha_envio = models.DateTimeField(auto_now_add=True) 

    def __str__(self):
        return self.mensaje


###### AUDITORÍA

# root/app/models.py

from django.db import models

class Auditoria(models.Model):
    ACCION_CHOICES = [
        ("CREAR", "Creación"),
        ("EDITAR", "Edición"),
        ("BORRAR", "Eliminación"),
        ("VALIDAR", "Validación"),
        ("RECHAZAR", "Rechazo"),
    ]

    usuario = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    tabla = models.CharField(max_length=100)
    registro_id = models.CharField(max_length=100)
    accion = models.CharField(max_length=20, choices=ACCION_CHOICES)
    descripcion = models.TextField(blank=True)
    fecha = models.DateTimeField(auto_now_add=True)

    valores_antes = models.JSONField(null=True, blank=True)
    valores_despues = models.JSONField(null=True, blank=True)

    def __str__(self):
        return f"{self.fecha} - {self.usuario} - {self.accion}"
