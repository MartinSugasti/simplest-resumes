import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import InvitationRequests from '../../components/admins/invitation_requests';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('admins-invitation-requests-container'));

    root.render(<InvitationRequests />);
  }
}
