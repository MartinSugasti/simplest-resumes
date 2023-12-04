import { redirect } from 'react-router-dom';
import translations from '../../../../locales/translations.json';

import { rejectPostulation } from '../api';
import { showErrorToast, showSuccessToast } from '../../../shared/Toaster';

// eslint-disable-next-line import/prefer-default-export
export const action = async ({ params }) => {
  try {
    await rejectPostulation(params.id, params.postulationId);
    const lang = document.querySelector('body').dataset.locale || 'en';
    const message = translations[lang].recruiters.job_postings.postulation_rejected;
    showSuccessToast(message);

    return redirect(`/recruiters/job_postings/${params.id}`);
  } catch (error) {
    const errorMessage = error.response?.data?.errors || error.message;
    showErrorToast(errorMessage);

    return redirect(`/recruiters/job_postings/${params.id}`);
  }
};
