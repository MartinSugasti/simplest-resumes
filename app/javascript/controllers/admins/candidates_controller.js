import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import Candidates from '../../components/admins/candidates';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('admins-candidates-container'));
    const config = window.adminsCandidatesConfig();

    root.render(
      <Candidates hasMasqueradePermissions={config.has_masquerade_permissions} />
    );
  }
}
