import { Controller } from '@hotwired/stimulus';
import React from 'react';
import { createRoot } from 'react-dom/client';

import JobPostings from '../../components/candidates/job_postings';

export default class extends Controller {
  connect() {
    const root = createRoot(document.getElementById('candidates-job-postings-container'));

    root.render(<JobPostings />);
  }
}
