/* eslint-disable no-nested-ternary */
import React, { useEffect } from 'react';
import {
  Link,
  useLoaderData,
  useOutletContext
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
  const { t } = useTranslation();

  useEffect(() => {
    setBreadcrumbs(`<strong>${t('dashboard.job_postings')}</strong>`);
  }, [setBreadcrumbs, t]);

  return (
    <div className="table-responsive">
      <table className="table table-striped text-center mb-0">
        <thead>
          <tr>
            <th>Id</th>
            <th>{t('activerecord.attributes.job_posting.title')}</th>
            <th>{t('activerecord.attributes.job_posting.company')}</th>
            <th>{t('activerecord.attributes.job_posting.skills')}</th>
            <th>{t('activerecord.attributes.job_posting.created_at')}</th>
            <th>{t('activerecord.attributes.job_posting.status')}</th>
          </tr>
        </thead>

        <tbody>
          {data.jobPostings && data.jobPostings.map((jobPosting) => (
            <tr key={jobPosting.id}>
              <td className="align-middle">{jobPosting.id}</td>
              <td className="align-middle">
                <Link to={`/candidates/job_postings/${jobPosting.id}`}>
                  {jobPosting.title}
                </Link>
              </td>
              <td className="align-middle">{jobPosting.company}</td>
              <td className="align-middle">{jobPosting.skills}</td>
              <td className="align-middle">{jobPosting.created_at}</td>
              <td className="align-middle">
                {!jobPosting.postulation_status ? (
                  '-'
                ) : jobPosting.postulation_status === t('activerecord.attributes.postulation.statuses.approved') ? (
                  <i className="bi bi-check-circle text-success" />
                ) : jobPosting.postulation_status === t('activerecord.attributes.postulation.statuses.rejected') ? (
                  <i className="bi bi-x-circle text-danger" />
                ) : (
                  <i className="bi bi-hourglass-split text-dark" />
                )}
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
  );
};

export default JobPostingsList;
