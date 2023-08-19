// Entry point for the build script in your package.json
import '@hotwired/turbo-rails';
import './controllers';
import * as bootstrap from 'bootstrap';

// Added for making bootstrap tooltips work
document.addEventListener('turbo:load', () => {
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));

  tooltipTriggerList.map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));
});
