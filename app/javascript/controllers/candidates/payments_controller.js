import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import Payments from '../../components/candidates/payments';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('candidates-payments-container'));

    root.render(<Payments />);
  }
}
