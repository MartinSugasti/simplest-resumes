import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import Payments from '../../components/admins/payments';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('admins-payments-container'));

    root.render(
      <Payments />
    );
  }
}
