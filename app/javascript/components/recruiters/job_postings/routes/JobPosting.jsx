import React, { useEffect } from 'react';
import {
  useLoaderData,
  useOutletContext,
  useNavigate,
  Form
} from 'react-router-dom';

import { getJobPosting } from '../api';

export const loader = async ({ params }) => {
  const response = await getJobPosting(params.id);

  return { jobPosting: response.data };
};

const JobPosting = () => {
  const { jobPosting } = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const navigate = useNavigate();

  useEffect(() => setBreadcrumbs('Job Postings / <strong>Show</strong>'), [setBreadcrumbs]);

  return (
    <>
      <div className="mb-3">
        <button
          type="button"
          className="border-0 btn m-0 p-0 text-decoration-underline text-primary"
          onClick={() => navigate(-1)}
        >
          Back
        </button>
      </div>

      <div className="d-flex">
        <h2 className="mb-0">
          {jobPosting.title}
          {' at '}
          {jobPosting.company}
        </h2>

        {/* eslint-disable-next-line max-len */}
        <div className={`align-middle align-self-center btn btn-outline-${jobPosting.published ? 'success' : 'danger'} btn-sm ms-3 rounded-pill`}>
          {jobPosting.published ? 'Published' : 'Unpublished'}
        </div>
      </div>

      <p className="fst-italic mb-0">{jobPosting.skills}</p>

      <div className="my-3">
        {jobPosting.description}
      </div>

      <h4 className="mt-4 mb-0">
        Candidates Postulated
      </h4>

      <div className="table-responsive">
        <table className="table table-striped text-center mb-0">
          <thead>
            <tr>
              <th>Id</th>
              <th>Email</th>
              <th>Skills</th>
              <th>Status</th>
              <th>Actions</th>
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
                    {postulation.status !== 'Approved' && (
                      <Form
                        method="post"
                        action={`/recruiters/job_postings/${jobPosting.id}/postulations/${postulation.id}/approve`}
                        className={`${postulation.status === 'Rejected' ? '' : 'me-2'}`}
                      >
                        <button
                          type="submit"
                          className="btn btn-success btn-sm rounded-pill"
                        >
                          Approve
                        </button>
                      </Form>
                    )}
                    {postulation.status !== 'Rejected' && (
                      <Form
                        method="post"
                        action={`/recruiters/job_postings/${jobPosting.id}/postulations/${postulation.id}/reject`}
                      >
                        <button
                          type="submit"
                          className="btn btn-danger btn-sm rounded-pill"
                        >
                          Reject
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
