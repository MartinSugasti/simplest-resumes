import React, { useEffect, useState } from 'react';
import {
  useLoaderData,
  useOutletContext,
  useNavigate,
  Form,
  redirect
} from 'react-router-dom';

import { getJobPosting, createPostulation } from '../api';
import { showSuccessToast, showErrorToast } from '../../../shared/Toaster';

export const loader = async ({ params }) => {
  const response = await getJobPosting(params.id);

  return { jobPosting: response.data };
};

export const action = async ({ params }) => {
  try {
    await createPostulation({ postulation: { job_posting_id: params.id } });
    showSuccessToast('You have successfully postulated!');

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

  useEffect(() => setBreadcrumbs('Job Postings / <strong>Show</strong>'), []);

  useEffect(() => {
    if (!jobPosting.postulation_id) { return; }

    setPostulationClass(() => {
      let className;

      switch (jobPosting.postulation_status) {
        case 'Pending':
          className = 'dark';
          break;
        case 'Approved':
          className = 'success';
          break;
        case 'Rejected':
          className = 'danger';
          break;
      }

      return className;
    })
  }, [jobPosting]);


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

      <div className="my-3">
        {jobPosting.description}
      </div>

      {jobPosting.postulation_id ? (
        <div className="d-flex">
          <span className={`align-self-center btn disabled btn-${postulationClass}`}>{jobPosting.postulation_status}</span>
          {jobPosting.postulation_status === 'Approved' && (
            <p className="align-self-center mb-0 ms-2">The recruiter will get in touch soon!</p>
          )}
        </div>
      ) : (
        <Form method="post">
          <button type="submit" className="btn btn-primary text-light">Postulate</button>
        </Form>
      )}
    </>
  );
};

export default JobPosting;
