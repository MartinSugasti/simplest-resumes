import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

import { getCandidates } from './api';

const Candidates = ({ hasMasqueradePermissions }) => {
  const [candidates, setCandidates] = useState([]);
  const { t } = useTranslation();

  useEffect(() => {
    getCandidates().then((response) => {
      setCandidates(response.data);
    }).catch((error) => console.log(error));
  }, []);

  return (
    <div className="table-responsive" id="admins-candidates-report">
      <table className="table table-striped text-center mb-0">
        <thead>
          <tr>
            <th>Id</th>
            <th>{t('activerecord.attributes.candidate.email')}</th>
            <th>{t('activerecord.attributes.candidate.created_at')}</th>
            <th>{t('activerecord.attributes.candidate.confirmed')}</th>
            {hasMasqueradePermissions && (
              <th>
                <i className="bi bi-box-arrow-in-right" />
              </th>
            )}
          </tr>
        </thead>

        <tbody>
          {candidates.map((candidate, index) => (
            // eslint-disable-next-line react/no-array-index-key
            <tr key={index}>
              <td>{candidate.id}</td>
              <td className="image-cell">
                <span>
                  {candidate.email}
                  {candidate.profile_picture_url && (
                    <img src={candidate.profile_picture_url} alt="Profile" className="ms-3 rounded-circle" />
                  )}
                </span>
              </td>
              <td>{candidate.created_at}</td>
              <td>{candidate['confirmed?'] ? t('general.yes') : t('general.no') }</td>
              {hasMasqueradePermissions && (
                <td>
                  <a href={`${candidate.sign_in_path}?resource_id=${candidate.id}`}>
                    {t('devise.shared.links.sign_in')}
                  </a>
                </td>
              )}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

Candidates.propTypes = {
  hasMasqueradePermissions: PropTypes.bool.isRequired
};

export default Candidates;
