import React, { useEffect } from 'react';
import {
  Link,
  useLoaderData,
  useOutletContext,
  useSubmit
} from 'react-router-dom';
import { useTranslation } from 'react-i18next';

import { getJobPostings } from '../api';
import ErrorPage from '../../../shared/ErrorPage';

export const loader = async () => {
  try {
    const response = await getJobPostings();

    return { jobPostings: response.data };
  } catch (error) {
    return { errorMessage: error.response?.data?.errors || error.message };
  }
};

const JobPostingsList = () => {
  const data = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const submit = useSubmit();
  const { t } = useTranslation();

  useEffect(() => {
    setBreadcrumbs(`<strong>${t('dashboard.job_postings')}</strong>`);
  }, [setBreadcrumbs, t]);

  return (
    <>
      <div className="mb-3">
        <Link to="/recruiters/job_postings/new" className="btn btn-outline-primary">
          {t('dashboard.new_job_posting')}
        </Link>
      </div>

      <div className="table-responsive">
        <table className="table table-striped text-center mb-0">
          <thead>
            <tr>
              <th>Id</th>
              <th>{t('activerecord.attributes.job_posting.title')}</th>
              <th>{t('activerecord.attributes.job_posting.company')}</th>
              <th>{t('activerecord.attributes.job_posting.skills')}</th>
              <th>{t('activerecord.attributes.job_posting.created_at')}</th>
              <th>{t('activerecord.attributes.job_posting.publish_inquiry')}</th>
              <th>{t('general.actions')}</th>
            </tr>
          </thead>

          <tbody>
            {data.jobPostings && data.jobPostings.map((jobPosting) => (
              <tr key={jobPosting.id}>
                <td className="align-middle">{jobPosting.id}</td>
                <td className="align-middle">
                  <Link to={`/recruiters/job_postings/${jobPosting.id}`}>
                    {jobPosting.title}
                  </Link>
                </td>
                <td className="align-middle">{jobPosting.company}</td>
                <td className="align-middle">{jobPosting.skills}</td>
                <td className="align-middle">{jobPosting.created_at}</td>
                <td className="align-middle">
                  {jobPosting.published ? (
                    t('activerecord.attributes.job_posting.published')
                  ) : (
                    t('activerecord.attributes.job_posting.unpublished')
                  )}
                </td>
                <td className="align-middle">
                  <Link to={`/recruiters/job_postings/${jobPosting.id}/edit`} className="text-dark">
                    <i className="bi bi-pencil-square me-2" />
                  </Link>

                  {/* eslint-disable-next-line jsx-a11y/click-events-have-key-events,
                  jsx-a11y/no-static-element-interactions */}
                  <span
                    onClick={() => {
                      // eslint-disable-next-line no-restricted-globals
                      if (confirm(t('general.confirm_record_deletion'))) {
                        submit(null, {
                          method: 'delete',
                          action: `/recruiters/job_postings/${jobPosting.id}/destroy`
                        });
                      }
                    }}
                    className="text-danger"
                  >
                    <i className="bi bi-trash" />
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        {data.errorMessage && (
          <div className="align-items-center d-flex justify-content-center my-5 py-5">
            <ErrorPage message={data.errorMessage} />
          </div>
        )}
      </div>
    </>
  );
};

export default JobPostingsList;
