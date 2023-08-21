import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import Home from '../components/home';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('home'));
    const config = window.homeConfig();

    root.render(<Home userSignedIn={config.user_signed_in} />);
  }
}
