// Auto-include HTML for any element with data-include="filename.html"
document.addEventListener("DOMContentLoaded", () => {
    const includeElements = document.querySelectorAll('[data-include]');

    includeElements.forEach(el => {
        const file = el.getAttribute('data-include');
        if (file) {
            fetch(file)
                .then(response => {
                    if (!response.ok) throw new Error('Failed to load ' + file);
                    return response.text();
                })
                .then(data => {
                    el.innerHTML = data;
                })
                .catch(err => console.error(err));
        }
    });
});


// Include navbar and footer
includeHTML('.navbar-placeholder', '/dev/web/navbar.html');
includeHTML('.footer-placeholder', '/dev/web/footer.html');


window.addEventListener('DOMContentLoaded', () => {
  console.log("Project Espresso page loaded.");
});


// Only run if it's a 404 and not already on 404.html
if (window.location.pathname !== '/404.html') {
    fetch(window.location.href, { method: 'HEAD' }).then(response => {
        if (!response.ok) {
            window.location.href = '/404.html';
        }
    });
}
