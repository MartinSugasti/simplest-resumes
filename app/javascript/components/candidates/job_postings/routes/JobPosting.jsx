import React, { useEffect } from 'react';
import {
  useLoaderData,
  useOutletContext,
  useNavigate
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

  useEffect(() => setBreadcrumbs('Job Postings / <strong>Show</strong>'), []);

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

      <h2 className="mb-0">
        {jobPosting.title}
        {' at '}
        {jobPosting.company}
      </h2>

      <p className="fst-italic mb-0">{jobPosting.skills}</p>

      <div className="mt-3">
        {jobPosting.description}
      </div>

      <p>{jobPosting.published}</p>
    </>
  );
};

export default JobPosting;
