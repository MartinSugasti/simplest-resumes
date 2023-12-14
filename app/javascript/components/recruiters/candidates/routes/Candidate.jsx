import React, { useState, useEffect } from 'react';
import {
  useLoaderData,
  useOutletContext,
  useNavigate
} from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { PDFDownloadLink } from '@react-pdf/renderer';

import Resume from '../components/Resume';
import { getCandidate, getResume } from '../api';
import { showErrorToast } from '../../../shared/Toaster';
import Pdf from '../../../candidates/my_resume/components/Pdf';

export const loader = async ({ params }) => {
  const response = await getCandidate(params.id);

  return { candidate: response.data };
};

const Candidate = () => {
  const { candidate } = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const navigate = useNavigate();
  const { t } = useTranslation();

  const [resumeData, setResumeData] = useState();

  useEffect(() => {
    setBreadcrumbs(`${t('dashboard.candidates')} / <strong>${t('dashboard.show')}</strong>`);
  }, [setBreadcrumbs, t]);

  useEffect(() => {
    if (!candidate.resume_id) { return; }

    getResume(candidate.resume_id)
      .then((response) => {
        console.log(response.data)
        setResumeData(response.data);
      })
      .catch(() => showErrorToast());
  }, [candidate]);

  return (
    <>
      <div className="d-flex justify-content-between mb-3">
        <button
          type="button"
          className="border-0 btn m-0 p-0 text-decoration-underline text-primary"
          onClick={() => navigate(-1)}
        >
          {t('general.back')}
        </button>

        <PDFDownloadLink document={<Pdf resume={resumeData} />} filName="myresume.pdf">
          {({ loading }) => (
            <button type="button" className="btn btn-outline-primary" disabled={loading || !resumeData}>
              {t('candidates.my_resume.show.download')}
            </button>
          )}
        </PDFDownloadLink>
      </div>

      <div>
        <div className="text-center">
          {candidate.profile_picture_url && (
            <img src={candidate.profile_picture_url} alt="Profile" className="rounded-circle w-25 shadow mb-3" />
          )}
        </div>
      </div>

      {resumeData ? (
        <Resume resumeData={resumeData} />
      ) : (
        <p className="h5 mb-0 text-center text-dark">{t('recruiters.candidates.no_resume')}</p>
      )}
    </>
  );
};

export default Candidate;
