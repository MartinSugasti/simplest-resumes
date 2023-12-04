import React, { useEffect, useState } from 'react';
import {
  useLoaderData,
  useOutletContext,
  useNavigate,
  Form,
  redirect
} from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import translations from '../../../../locales/translations.json';

import { getJobPosting, createPostulation } from '../api';
import { showSuccessToast, showErrorToast } from '../../../shared/Toaster';

export const loader = async ({ params }) => {
  const response = await getJobPosting(params.id);

  return { jobPosting: response.data };
};

export const action = async ({ params }) => {
  try {
    await createPostulation({ postulation: { job_posting_id: params.id } });
    const lang = document.querySelector('body').dataset.locale || 'en';
    const message = translations[lang].candidates.job_postings.successfully_postulated;
    showSuccessToast(message);

    return redirect('/candidates/job_postings');
  } catch (error) {
    const errorMessage = error.response?.data?.errors || error.message;
    showErrorToast(errorMessage);

    return null;
  }
};

const JobPosting = () => {
  const { jobPosting } = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const navigate = useNavigate();
  const [postulationClass, setPostulationClass] = useState();
  const { t } = useTranslation();

  useEffect(() => {
    setBreadcrumbs(`${t('dashboard.job_postings')} / <strong>${t('dashboard.show')}</strong>`);
  }, [setBreadcrumbs, t]);

  useEffect(() => {
    if (!jobPosting.postulation_id) { return; }

    setPostulationClass(() => {
      let className;

      switch (jobPosting.postulation_status) {
        case t('activerecord.attributes.postulation.statuses.pending'):
          className = 'dark';
          break;
        case t('activerecord.attributes.postulation.statuses.approved'):
          className = 'success';
          break;
        case t('activerecord.attributes.postulation.statuses.rejected'):
          className = 'danger';
          break;
        default:
          className = 'dark';
      }

      return className;
    });
  }, [jobPosting, t]);

  return (
    <>
      <div className="mb-3">
        <button
          type="button"
          className="border-0 btn m-0 p-0 text-decoration-underline text-primary"
          onClick={() => navigate(-1)}
        >
          {t('general.back')}
        </button>
      </div>

      <h2 className="mb-0">
        {jobPosting.title}
        {` ${t('general.at')} `}
        {jobPosting.company}
      </h2>

      <p className="fst-italic mb-0">{jobPosting.skills}</p>

      <div className="my-3">
        {jobPosting.description}
      </div>

      {jobPosting.postulation_id ? (
        <div className="d-flex">
          <span
            className={`align-self-center btn disabled btn-${postulationClass}`}
          >
            {jobPosting.postulation_status}
          </span>
          {jobPosting.postulation_status === t('activerecord.attributes.postulation.statuses.approved') && (
            <p className="align-self-center mb-0 ms-2">{t('candidates.job_postings.recruiter_will_get_in_touch')}</p>
          )}
        </div>
      ) : (
        <Form method="post">
          <button type="submit" className="btn btn-primary text-light">{t('candidates.job_postings.postulate')}</button>
        </Form>
      )}
    </>
  );
};

export default JobPosting;
