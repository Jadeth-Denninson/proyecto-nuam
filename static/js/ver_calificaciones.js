document.addEventListener("DOMContentLoaded", () => {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  [...tooltipTriggerList].map(t => new bootstrap.Tooltip(t));
});

function obtenerSeleccion() {
  return document.querySelector("input[name='seleccion']:checked")?.value;
}

function editarSeleccionado() {
  const id = obtenerSeleccion();
  if (!id) {
    alert("Debe seleccionar una calificación primero.");
    return;
  }
  window.location.href = `http://127.0.0.1:8000/gestores/calificaciones/editar/${id}`;
}

function eliminarSeleccionado() {
  const id = obtenerSeleccion();
  if (!id) {
    alert("Debe seleccionar una calificación primero.");
    return;
  }
  if (confirm("¿Está seguro de eliminar la calificación seleccionada?")) {
    window.location.href = `http://127.0.0.1:8000/gestores/calificaciones/eliminar/${id}`;
  }
}

function startFakeLoader() {
    const bar = document.getElementById("loader-bar");
    const loader = document.getElementById("loader");

    loader.style.display = "block";
    bar.style.width = "0%";

    let progress = 0;
    const interval = setInterval(() => {
        progress += Math.random() * 15;  // efecto random tipo realista
        bar.style.width = Math.min(progress, 100) + "%";

        if (progress >= 100) {
            clearInterval(interval);
        }
    }, 200);
}

document.querySelector("input[type='file']").addEventListener("change", () => {
    startFakeLoader();
});