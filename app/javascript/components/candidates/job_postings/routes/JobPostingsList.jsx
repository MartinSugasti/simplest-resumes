import React, { useEffect } from 'react';
import {
  Link,
  useLoaderData,
  useOutletContext
} from 'react-router-dom';

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

  useEffect(() => {
    setBreadcrumbs('<strong>Job Postings</strong>');
  }, []);

  return (
    <>
      <div className="table-responsive">
        <table className="table table-striped text-center mb-0">
          <thead>
            <tr>
              <th>Id</th>
              <th>Title</th>
              <th>Company</th>
              <th>Skills</th>
              <th>Created At</th>
              <th>Status</th>
            </tr>
          </thead>

          <tbody>
            {data.jobPostings && data.jobPostings.map((jobPosting) => (
              // eslint-disable-next-line react/no-array-index-key
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
                  ) : jobPosting.postulation_status === 'Approved' ? (
                    <i className="bi bi-check-circle fa-2x text-success" />
                  ) : jobPosting.postulation_status === 'Rejected' ? (
                    <i className="bi bi-x-circle fa-2x text-danger" />
                  ) : (
                    <i className="bi bi-hourglass-split fa-2x text-dark" />
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
    </>
  );
};

export default JobPostingsList;
