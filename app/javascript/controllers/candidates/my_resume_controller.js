import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import MyResume from '../../components/candidates/my_resume';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('candidates-my-resume-container'));

    root.render(<MyResume />);
  }
}
