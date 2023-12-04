import React, { useEffect } from 'react';
import {
  useLoaderData,
  useOutletContext,
  useNavigate,
  Form
} from 'react-router-dom';
import { useTranslation } from 'react-i18next';

import { getJobPosting } from '../api';

export const loader = async ({ params }) => {
  const response = await getJobPosting(params.id);

  return { jobPosting: response.data };
};

const JobPosting = () => {
  const { jobPosting } = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const navigate = useNavigate();
  const { t } = useTranslation();

  useEffect(() => {
    setBreadcrumbs(`${t('dashboard.job_postings')} / <strong>${t('dashboard.show')}</strong>`);
  }, [setBreadcrumbs, t]);

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

      <div className="d-flex">
        <h2 className="mb-0">
          {jobPosting.title}
          {` ${t('general.at')} `}
          {jobPosting.company}
        </h2>

        {/* eslint-disable-next-line max-len */}
        <div className={`align-middle align-self-center btn btn-outline-${jobPosting.published ? 'success' : 'danger'} btn-sm ms-3 rounded-pill`}>
          {jobPosting.published ? (
            t('activerecord.attributes.job_posting.published')
          ) : (
            t('activerecord.attributes.job_posting.unpublished')
          )}
        </div>
      </div>

      <p className="fst-italic mb-0">{jobPosting.skills}</p>

      <div className="my-3">
        {jobPosting.description}
      </div>

      <h4 className="mt-4 mb-0">
        {t('recruiters.job_postings.candidates_postulated')}
      </h4>

      <div className="table-responsive">
        <table className="table table-striped text-center mb-0">
          <thead>
            <tr>
              <th>Id</th>
              <th>{t('activerecord.attributes.candidate.email')}</th>
              <th>{t('activerecord.attributes.candidate.primary_skill_items')}</th>
              <th>{t('activerecord.attributes.postulation.status')}</th>
              <th>{t('general.actions')}</th>
            </tr>
          </thead>

          <tbody>
            {jobPosting.postulations.map((postulation) => (
              <tr key={postulation.id}>
                <td className="align-middle">{postulation.candidate.id}</td>
                <td className="align-middle">
                  <a href={`/recruiters/candidates/${postulation.candidate.id}`} data-turbo={false}>
                    {postulation.candidate.email}
                  </a>
                </td>
                <td className="align-middle">{postulation.candidate.primary_skills}</td>
                <td className="align-middle">{postulation.status}</td>
                <td className="align-middle">
                  <div className="d-flex justify-content-center">
                    {postulation.status !== t('activerecord.attributes.postulation.statuses.approved') && (
                      <Form
                        method="post"
                        action={`/recruiters/job_postings/${jobPosting.id}/postulations/${postulation.id}/approve`}
                        // eslint-disable-next-line max-len
                        className={`${postulation.status === t('activerecord.attributes.postulation.statuses.rejected') ? '' : 'me-2'}`}
                      >
                        <button
                          type="submit"
                          className="btn btn-success btn-sm rounded-pill"
                        >
                          {t('recruiters.job_postings.approve')}
                        </button>
                      </Form>
                    )}
                    {postulation.status !== t('activerecord.attributes.postulation.statuses.rejected') && (
                      <Form
                        method="post"
                        action={`/recruiters/job_postings/${jobPosting.id}/postulations/${postulation.id}/reject`}
                      >
                        <button
                          type="submit"
                          className="btn btn-danger btn-sm rounded-pill"
                        >
                          {t('recruiters.job_postings.reject')}
                        </button>
                      </Form>
                    )}
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
};

export default JobPosting;
