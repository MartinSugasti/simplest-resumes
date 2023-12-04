import { redirect } from 'react-router-dom';
import translations from '../../../../locales/translations.json';

import { destroyJobPosting } from '../api';
import { showErrorToast, showSuccessToast } from '../../../shared/Toaster';

// eslint-disable-next-line import/prefer-default-export
export const destroyAction = async ({ params }) => {
  try {
    await destroyJobPosting(params.id);
    const lang = document.querySelector('body').dataset.locale || 'en';
    const message = translations[lang].recruiters.job_postings.deleted;
    showSuccessToast(message);

    return redirect('/recruiters/job_postings');
  } catch (error) {
    const errorMessage = error.response?.data?.errors || error.message;
    showErrorToast(errorMessage);

    return redirect('/recruiters/job_postings');
  }
};
