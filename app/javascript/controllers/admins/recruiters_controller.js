import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import Recruiters from '../../components/admins/recruiters';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('admins-recruiters-container'));
    const config = window.adminsRecruitersConfig();

    root.render(
      <Recruiters hasMasqueradePermissions={config.has_masquerade_permissions} />
    );
  }
}
