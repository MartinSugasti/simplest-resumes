import { redirect } from 'react-router-dom';

import { destroyJobPosting } from '../api';
import { showErrorToast, showSuccessToast } from '../../../shared/Toaster';

export const destroyAction = async ({ request, params }) => {
  try {
    await destroyJobPosting(params.id);
    showSuccessToast('Job Posting successfully deleted!');

    return redirect('/recruiters/job_postings');
  } catch (error) {
    const errorMessage = error.response?.data?.errors || error.message;
    showErrorToast(errorMessage);

    return redirect('/recruiters/job_postings');
  }
};
