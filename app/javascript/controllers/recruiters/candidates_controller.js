import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import Candidates from '../../components/recruiters/candidates';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('recruiters-candidates-container'));

    root.render(
      <Candidates />
    );
  }
}
