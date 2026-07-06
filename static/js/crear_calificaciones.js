document.addEventListener('DOMContentLoaded', () => {
  // Inicializa carousel (si no existe, crea)
  const wizardEl = document.querySelector('#wizard');
  if (wizardEl) {
    window.wizardCarousel = bootstrap.Carousel.getInstance(wizardEl) || new bootstrap.Carousel(wizardEl, {
      interval: false,
      touch: false,
      ride: false
    });

    // Antes de que empiece la slide, copiamos valores cuando vamos a step2
    wizardEl.addEventListener('slide.bs.carousel', (ev) => {
      // ev.to es el index del slide destino
      const items = Array.from(wizardEl.querySelectorAll('.carousel-item'));
      const target = items[ev.to];
      if (!target) return;

      // Si el destino tiene id="step2", sincronizamos desde step1
      if (target.id === 'step2') {
        copyStep1ToStep2();
        // Deshabilitar campos del step2 (visualmente) luego del pequeño delay
        setTimeout(() => {
          disableStep2Fields();
          swap(); // actualiza botón por si el checkbox cambia por copia
        }, 60);
      } else {
        // Si volvemos a step1, re-enable step1 (no necesitamos habilitar step2)
        enableStep1Fields();
      }
    });
  } else {
    console.warn("Wizard element (#wizard) no encontrado.");
  }

  // swap: checkbox ingreso por montos - robusto (busca en DOM)
  const ingresoChk = document.querySelector("input[name='ingreso_montos'], #ingreso_montos");
  if (ingresoChk) {
    ingresoChk.addEventListener('change', swap);
  }
  // initial run
  swap();
});


function copyStep1ToStep2() {
  const step1 = document.getElementById('step1');
  const step2 = document.getElementById('step2');
  if (!step1 || !step2) return;

  // Campos que queremos sincronizar: selector por name y por id
  const fields = [
    'mercado', 'instrumento', 'descripcion', 'fecha_pago',
    'secuencia_evento', 'dividendo', 'valor_historico', 'anio', 'isfut'
  ];

  fields.forEach(name => {
    // busca en step1 y step2
    const src = step1.querySelector(`[name='${name}'], #${name}`);
    const dst = step2.querySelector(`[name='${name}'], #${name}`);

    if (!src || !dst) {
      // a veces los selects son <select> y en dst hay un span/readonly; manejamos casos comunes
      // si no hay dst, ignoramos
      return;
    }


    if (src.tagName === 'SELECT') {
      try {
        dst.value = src.value;
      } catch (e) { /* no crítico */ }
    } else if (src.type === 'checkbox' || src.type === 'radio') {
      dst.checked = src.checked;
      // si el dst es checkbox, mantener visual; pero quitar name para que no duplique el envío
    } else {
      dst.value = src.value;
    }

    if (dst.hasAttribute('name')) {
      dst.removeAttribute('name');
    }

    dst.setAttribute('data-copied-from', name);
  });
}


function disableStep2Fields() {
  const step2 = document.getElementById("step2");
  if (!step2) return;

  // campos duplicados que deben quedar solo de lectura en step2
  const duplicated = [
    'mercado',
    'instrumento',
    'valor_historico',
    'fecha_pago',
    'descripcion',
    'secuencia_evento',
    'anio',
    'isfut',
    'dividendo',
  ];

  duplicated.forEach(name => {
    // Buscar por name o por id, cualquiera
    const field = step2.querySelector(`[name='${name}'], #${name}`);
    if (field) {
      field.setAttribute("disabled", true);
      field.classList.add("bg-light");

      // quitar name para evitar duplicado en el POST
      if (field.hasAttribute('name')) {
        field.removeAttribute('name');
      }
    }
  });

  // Dejamos intactos:
  // - evento_capital
  // - ingreso_montos
  // - factores
  // - cualquier otro campo personalizado del step2
}


/* ---- enable step1 fields (por si regresamos) ---- */
function enableStep1Fields() {
  const step1 = document.getElementById("step1");
  if (!step1) return;
  const activeFields = step1.querySelectorAll("input, select, textarea");
  activeFields.forEach(f => {
    // quitamos readonly/disabled visual (no siempre estaban)
    if (f.hasAttribute('disabled')) f.removeAttribute('disabled');
    if (f.hasAttribute('readonly')) f.removeAttribute('readonly');
    f.classList.remove('bg-light');
  });
}

/* ---- swap: ajusta botón y factores según checkbox ---- */
function swap(){
  // checkbox: puede estar en step2 o en DOM, buscamos ambos
  const ingreso_por_montos = document.querySelector("input[name='ingreso_montos'], #ingreso_montos");
  const form_btn = document.getElementById("form-btn");
  const inputs = document.querySelectorAll("input[name^='factor'], input[id^='factor']");

  if (!form_btn) {
    // si no existe aún, nada que hacer
    return;
  }

  const checked = ingreso_por_montos ? ingreso_por_montos.checked : false;

  if (checked) {
    form_btn.innerText = 'CALCULAR';
    form_btn.name = "calcular";

    inputs.forEach(input => {
      input.step = "1";
      input.min = "0";
      input.removeAttribute('max');
    });
  }
  else {
    form_btn.innerText = 'INGRESAR';
    form_btn.name = "ingresar";

    inputs.forEach(input => {
      input.step = "0.00000001";
      input.min = "0";
      input.max = "1";
    });
  }
}

/* ---- helpers de navegación desde botones ---- */
function goStep2() {
  const paso = document.getElementById("paso");
  if (paso) paso.value = "2";
  if (window.wizardCarousel) {
    window.wizardCarousel.next();
  } else {
    console.error("wizardCarousel no inicializado.");
  }
}

function goStep1() {
  const paso = document.getElementById("paso");
  if (paso) paso.value = "1";
  if (window.wizardCarousel) {
    window.wizardCarousel.prev();
  } else {
    console.error("wizardCarousel no inicializado.");
  }
}
