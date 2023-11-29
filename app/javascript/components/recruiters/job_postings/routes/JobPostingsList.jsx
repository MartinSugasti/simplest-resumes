/* eslint-disable jsx-a11y/no-static-element-interactions */
/* eslint-disable jsx-a11y/click-events-have-key-events */
/* eslint-disable react/jsx-no-comment-textnodes */
/* eslint-disable max-len */
import React, { useEffect } from 'react';
import {
  Link,
  useLoaderData,
  useOutletContext,
  useSubmit
} from 'react-router-dom';

import { getJobPostings } from '../api';

export const loader = async () => {
  const response = await getJobPostings();

  return { jobPostings: response.data };
};

const JobPostingsList = () => {
  const { jobPostings } = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const submit = useSubmit();

  useEffect(() => {
    setBreadcrumbs('<strong>Job Postings</strong>');
  }, []);

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
              <th>Created At</th>
              <th>Company</th>
              <th>Skills</th>
              <th>Published</th>
              <th>Actions</th>
            </tr>
          </thead>

          <tbody>
            {jobPostings.map((jobPosting) => (
              // eslint-disable-next-line react/no-array-index-key
              <tr key={jobPosting.id}>
                <td>{jobPosting.id}</td>
                <td>{jobPosting.title}</td>
                <td>{jobPosting.created_at}</td>
                <td>{jobPosting.company}</td>
                <td>{jobPosting.skills}</td>
                <td>{jobPosting.published ? 'Published' : 'Unpublished'}</td>
                <td>
                  <Link to={`/recruiters/job_postings/${jobPosting.id}/edit`} className="text-dark">
                    <i className="bi bi-pencil-square me-2" />
                  </Link>

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
      </div>
    </>
  );
};

export default JobPostingsList;
