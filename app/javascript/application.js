// Entry point for the build script in your package.json
import '@hotwired/turbo-rails';
import './controllers';
import * as bootstrap from 'bootstrap';

document.addEventListener('turbo:load', () => {
  // Added for making bootstrap tooltips work
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));

  tooltipTriggerList.map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));

  // Added for making sidebar toggle
  const sidebarToggler = document.querySelector('#sidebar-toggler');

  if (sidebarToggler) {
    sidebarToggler.addEventListener('click', () => {
      document.querySelector('#sidebar').classList.toggle('collapsed');
    });
  }
});
