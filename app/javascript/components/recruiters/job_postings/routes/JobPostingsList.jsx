import React, { useEffect } from 'react';
import {
  Link,
  useLoaderData,
  useOutletContext,
  useSubmit
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
  const submit = useSubmit();

  useEffect(() => {
    setBreadcrumbs('<strong>Job Postings</strong>');
  }, [setBreadcrumbs]);

  return (
    <>
      <div className="mb-3">
        <Link to="/recruiters/job_postings/new" className="btn btn-outline-primary">
          New Job Posting
        </Link>
      </div>

      <div className="table-responsive">
        <table className="table table-striped text-center mb-0">
          <thead>
            <tr>
              <th>Id</th>
              <th>Title</th>
              <th>Company</th>
              <th>Skills</th>
              <th>Created At</th>
              <th>Published</th>
              <th>Actions</th>
            </tr>
          </thead>

          <tbody>
            {data.jobPostings && data.jobPostings.map((jobPosting) => (
              // eslint-disable-next-line react/no-array-index-key
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
                <td className="align-middle">{jobPosting.published ? 'Published' : 'Unpublished'}</td>
                <td className="align-middle">
                  <Link to={`/recruiters/job_postings/${jobPosting.id}/edit`} className="text-dark">
                    <i className="bi bi-pencil-square me-2" />
                  </Link>

                  {/* eslint-disable-next-line jsx-a11y/click-events-have-key-events,
                  jsx-a11y/no-static-element-interactions */}
                  <span
                    onClick={() => {
                      // eslint-disable-next-line no-restricted-globals
                      if (confirm('Please confirm you want to delete this record.')) {
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
