import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import Payments from '../../components/candidates/subscriptions';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('candidates-subscriptions-container'));

    root.render(<Payments />);
  }
}
