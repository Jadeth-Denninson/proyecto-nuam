document.addEventListener("DOMContentLoaded", function () {

    const btn = document.getElementById("btnNotificaciones");
    const dropdown = document.getElementById("notifDropdown");
    const content = document.getElementById("notifContent");
    const dot = document.getElementById("notifDot");

    function cargarNotificaciones() {
        fetch("/notificaciones/panel/")
            .then(res => res.text())
            .then(html => {
                content.innerHTML = html;

                const unread = content.querySelectorAll(".no-leido").length;

                if (unread > 0) {
                    dot.classList.remove("dot-hidden");
                    dot.classList.add("dot-visible");
                } else {
                    dot.classList.remove("dot-visible");
                    dot.classList.add("dot-hidden");
                }
            });
    }

    btn.addEventListener("click", () => {
        dropdown.classList.toggle("hidden");
        cargarNotificaciones();
    });

    setInterval(cargarNotificaciones, 5000);

    cargarNotificaciones();
});