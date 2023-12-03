import { redirect } from 'react-router-dom';

import { rejectPostulation } from '../api';
import { showErrorToast, showSuccessToast } from '../../../shared/Toaster';

export const action = async ({ params }) => {
  try {
    await rejectPostulation(params.id, params.postulationId);
    showSuccessToast('Postulation successfully rejected!');

    return redirect(`/recruiters/job_postings/${params.id}`);
  } catch (error) {
    console.log(error)
    const errorMessage = error.response?.data?.errors || error.message;
    showErrorToast(errorMessage);

    return redirect(`/recruiters/job_postings/${params.id}`);
  }
};
