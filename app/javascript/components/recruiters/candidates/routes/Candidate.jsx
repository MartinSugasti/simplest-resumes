import React, { useState, useEffect } from 'react';
import {
  useLoaderData,
  useOutletContext,
  useNavigate
} from 'react-router-dom';

import Resume from '../components/Resume';
import { getCandidate, getResume } from '../api';
import { showErrorToast } from '../../../shared/Toaster';

export const loader = async ({ params }) => {
  const response = await getCandidate(params.id);

  return { candidate: response.data };
};

const Candidate = () => {
  const { candidate } = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const navigate = useNavigate();

  const [resumeData, setResumeData] = useState();

  useEffect(() => setBreadcrumbs('Candidates / <strong>Show</strong>'), []);

  useEffect(() => {
    if (!candidate.resume_id) { return; }

    getResume(candidate.resume_id)
      .then((response) => setResumeData(response.data))
      .catch(() => showErrorToast("Someting went wrong when retrieving candidate's resume"));
  }, [candidate]);

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

      <div>
        <div className="text-center">
          {candidate.profile_picture_url && (
            <img src={candidate.profile_picture_url} alt="Profile" className="rounded-circle w-25 shadow mb-3" />
          )}
        </div>
      </div>

      {resumeData && <Resume resumeData={resumeData} />}
    </>
  );
};

export default Candidate;
