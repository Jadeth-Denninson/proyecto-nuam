from django import forms
from .models import *

# LOGIN
class LoginForm(forms.Form):
    email = forms.EmailField(widget=forms.EmailInput(attrs={
        'class': 'form-control',
        'placeholder': 'Correo Electrónico'
    }))
    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'class': 'form-control',
        'placeholder': 'Contraseña'
    }))

# CALIFICACIONES
class CalificacionTributariaForm(forms.ModelForm):
    class Meta:
        model = calificacion_tributaria
        fields = [
            'mercado', 'instrumento', 'descripcion', 'fecha_pago',
            'secuencia_evento', 'dividendo', 'valor_historico',
            'anio', 'isfut'
        ]
        widgets = {
            'mercado': forms.Select(attrs={
                'class': 'form-control',
                'id': 'mercado',
                'name': 'mercado',
            }),
            'instrumento': forms.Select(attrs={
                'class': 'form-control',
                'id': 'instrumento',
                'name': 'instrumento',
            }),
            'descripcion': forms.TextInput(attrs={
                'class': 'form-control',
                'id': 'descripcion',
                'name': 'descripcion',
                'placeholder': 'JEEP ACC 1X1',
                'required': True
            }),
            'fecha_pago': forms.DateInput(attrs={
                'class': 'form-control',
                'id': 'fecha_pago',
                'name': 'fecha_pago',
                'placeholder': '2025-01-02',
                'type': 'date',
                'required': True
            }),
            'secuencia_evento': forms.NumberInput(attrs={
                'class': 'form-control',
                'id': 'secuencia_evento',
                'name': 'secuencia_evento',
                'placeholder': '100000809',
                'min': '10000',
                'required': True
            }),
            'dividendo': forms.NumberInput(attrs={
                'class': 'form-control',
                'id': 'dividendo',
                'name': 'dividendo',
                'placeholder': 'Ingrese dividendo',
            }),
            'valor_historico': forms.NumberInput(attrs={
                'class': 'form-control',
                'id': 'valor_historico',
                'name': 'valor_historico',
                'placeholder': '1000000',
                'required': True
            }),
            'anio': forms.NumberInput(attrs={
                'class': 'form-control',
                'id': 'anio',
                'name': 'anio',
                'placeholder': '2025',
                'min': "1970",
                'max': "2200",
                'required': True
            })
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.fields['instrumento'].queryset = instrumento_financiero.objects.all().order_by('codigo')
        self.fields['instrumento'].label_from_instance = lambda obj: f"{obj.codigo} — {obj.descripcion}"

        #<select class="form-select" name="mercado">
        #    <option value="">Seleccione...</option>
        #    <option>Acciones</option>
        #    <option>Renta Fija</option>
        #    <option>Derivados Financieros</option>
        #    <option>Fondos de Inversión-Mutuos</option>
        #    <option>Instrumentos del Banco Central</option>
        #    <option>Instrumentos del Estado-Tesorería</option>
        #    <option>Mercado Monetario</option>
        #    <option>Mercado Internacional</option>
        #    <option>Mercado Bancario-Créditos</option>
        #</select>

        # Agregar campos dinámicos para los factores desde la BD
        for f in factor_calificacion.objects.all():
            self.fields[f"factor{f.factor_id}"] = forms.DecimalField(
                required=False,
                label=f.nombre_factor,
                widget=forms.NumberInput(attrs={
                    'class': 'form-control text-end',
                    'step': '0.0001',
                    'placeholder': '0.0000',
                    'id': f'factor{f.factor_id}',
                    'name': f'factor{f.factor_id}',
                })
            )

# INSTRUMENTOS
categorias_instrumentos = [
  ("Efectivo y Depósitos","Efectivo y Depósitos"), 
  ("Títulos de Deuda (Renta Fija)","Títulos de Deuda (Renta Fija)"), 
  ("Acciones y Participaciones","Acciones y Participaciones"), 
  ("Derivados Financieros","Derivados Financieros"), 
  ("Préstamos","Préstamos"), 
  ("Fondos","Fondos"), 
  ("Otras Cuentas-Derechos","Otras Cuentas-Derechos")
  ]

bolsas_instrumentos = [
  ("BCS", "Bolsa de Comercio de Santiago (Chile)"),
  ("BVC","Bolsa de Valores de Colombia"), 
  ('BVL',"Bolsa de Valores de Lima (Perú)")
  ]

mercados_instrumentos = [
  ("Acciones", "Acciones"),
  ("Renta Fija","Renta Fija"),
  ("Derivados","Derivados Financieros"),
  ("Fondos de Inversión-Mutuos","Fondos de Inversión-Mutuos" ),
  ("Instrumentos del Banco Central","Instrumentos del Banco Central" ),
  ("Instrumentos del Estado-Tesorería","Instrumentos del Estado-Tesorería" ), 
  ("Mercado Monetario","Mercado Monetario"), 
  ("Mercado Internacional","Mercado Internacional"), 
  ("Mercado Bancario-Créditos","Mercado Bancario-Créditos")]

estados_instrumentos = [
  ("Ingresado","Ingresado"),
  ("Validado","Validado"),
  ("Rechazado","Rechazado")
  ]

class formInstrumentoFinanciero(forms.Form):
  codigo = forms.CharField(max_length=6, widget=forms.TextInput(attrs={'class':'form-control',
  'placeholder': '### ###'}))
  descripcion = forms.CharField(max_length=150, widget=forms.Textarea(attrs={'class':'form-control',
  'placeholder': 'Descripción...'}))
  categoria = forms.ChoiceField(choices=categorias_instrumentos, widget=forms.Select(attrs={'class':'form-select'}))
  bolsa = forms.ChoiceField(choices=bolsas_instrumentos, widget=forms.Select(attrs={'class':'form-select'}))
  mercado = forms.ChoiceField(choices=mercados_instrumentos, widget=forms.Select(attrs={'class':'form-select'}))
  #estado = forms.ChoiceField(choices=estado_instrumentos, widget=forms.Select(attrs={'class':'form-select'}))

class formSolicitud(forms.ModelForm):
    usuario_display = forms.CharField(
        label="Usuario",
        disabled=True,
        required=False,
        widget=forms.TextInput(attrs={
            "class": "form-control text-white bg-dark border-secondary",
            "style": "color: white;"
        })
    )

    class Meta:
        model = solicitud
        fields = ["motivo"]
        widgets = {
            "motivo": forms.Textarea(attrs={
                "rows": 4,
                "class": "form-control text-white bg-dark border-secondary",
                "placeholder": "Escribe el motivo...",
                "style": "color: white;"
            })
        }

class formSolicitudCliente(forms.ModelForm):
    class Meta:
        model = solicitud
        fields = ["calificacion", "motivo"]
        widgets = {
            "calificacion": forms.Select(attrs={
                "class": "form-select text-white bg-dark border-secondary",
                "style": "color: white;"
            }),
            "motivo": forms.Textarea(attrs={
                "rows": 4,
                "class": "form-control text-white bg-dark border-secondary",
                "placeholder": "Escribe el motivo de la consulta...",
                "style": "color: white;"
            })
        }
    def __init__(self, cliente=None, *args, **kwargs):
        super(formSolicitudCliente, self).__init__(*args, **kwargs)
        if cliente:
            self.fields['calificacion'].queryset = calificacion_tributaria.objects.filter(cliente=cliente)