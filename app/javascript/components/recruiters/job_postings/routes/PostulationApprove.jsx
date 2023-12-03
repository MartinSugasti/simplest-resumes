import { redirect } from 'react-router-dom';

import { approvePostulation } from '../api';
import { showErrorToast, showSuccessToast } from '../../../shared/Toaster';

export const action = async ({ params }) => {
  try {
    await approvePostulation(params.id, params.postulationId);
    showSuccessToast('Postulation successfully approved!');

    return redirect(`/recruiters/job_postings/${params.id}`);
  } catch (error) {
    const errorMessage = error.response?.data?.errors || error.message;
    showErrorToast(errorMessage);

    return redirect(`/recruiters/job_postings/${params.id}`);
  }
};
