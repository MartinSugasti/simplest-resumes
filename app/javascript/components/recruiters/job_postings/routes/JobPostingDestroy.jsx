/* eslint-disable import/prefer-default-export */
import { redirect } from 'react-router-dom';

import { destroyJobPosting } from '../api';

export const destroyAction = async ({ params }) => {
  await destroyJobPosting(params.id);

  return redirect('/recruiters/job_postings');
};
