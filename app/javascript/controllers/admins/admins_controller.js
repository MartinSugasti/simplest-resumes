import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import Admins from '../../components/admins/admins';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('admins-admins-container'));

    root.render(<Admins />);
  }
}
