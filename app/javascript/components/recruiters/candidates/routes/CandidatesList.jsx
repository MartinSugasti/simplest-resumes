import React, { useEffect } from 'react';
import {
  Link,
  useLoaderData,
  useOutletContext
} from 'react-router-dom';
import { useTranslation } from 'react-i18next';

import { getCandidates } from '../api';
import ErrorPage from '../../../shared/ErrorPage';

export const loader = async () => {
  try {
    const response = await getCandidates();

    return { candidates: response.data };
  } catch (error) {
    return { errorMessage: error.response?.data?.errors || error.message };
  }
};

const CandidatesList = () => {
  const data = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const { t } = useTranslation();

  useEffect(() => {
    setBreadcrumbs('<strong>Candidates</strong>');
  }, [setBreadcrumbs]);

  return (
    <div className="table-responsive" id="admins-candidates-report">
      <table className="table table-striped text-center mb-0">
        <thead>
          <tr>
            <th>Id</th>
            <th>{t('activerecord.attributes.candidate.email')}</th>
            <th>Skills</th>
          </tr>
        </thead>

        <tbody>
          {data.candidates.map((candidate, index) => (
            // eslint-disable-next-line react/no-array-index-key
            <tr key={index}>
              <td className="align-middle">{candidate.id}</td>
              <td className="image-cell align-middle">
                <span>
                  <Link to={`/recruiters/candidates/${candidate.id}`}>
                    {candidate.email}
                  </Link>
                  {candidate.profile_picture_url && (
                    <img src={candidate.profile_picture_url} alt="Profile" className="ms-3 rounded-circle" />
                  )}
                </span>
              </td>
              <td className="align-middle">{candidate.primary_skills}</td>
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

export default CandidatesList;
