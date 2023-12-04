import { redirect } from 'react-router-dom';

import { destroyJobPosting } from '../api';
import { showErrorToast, showSuccessToast } from '../../../shared/Toaster';

// eslint-disable-next-line import/prefer-default-export
export const destroyAction = async ({ params }) => {
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
