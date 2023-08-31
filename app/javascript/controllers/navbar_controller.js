import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import Navbar from '../components/navbar';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('dashboard-navbar'));
    const config = window.navbarConfig();

    root.render(<Navbar user={config.user} />);
  }
}
