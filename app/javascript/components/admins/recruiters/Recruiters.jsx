import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import i18n from '../../shared/i18n';

import { getRecruiters } from './api';

const Recruiters = ({ hasMasqueradePermissions }) => {
  const [recruiters, setRecruiters] = useState([]);

  useEffect(() => {
    getRecruiters().then((response) => {
      setRecruiters(response.data);
    }).catch((error) => console.log(error));
  }, []);

  return (
    <div className="table-responsive" id="admins-recruiters-report">
      <table className="table table-striped text-center mb-0">
        <thead>
          <tr>
            <th>Id</th>
            <th>{i18n.t('activerecord.attributes.recruiter.email')}</th>
            <th>{i18n.t('activerecord.attributes.recruiter.created_at')}</th>
            <th>{i18n.t('activerecord.attributes.recruiter.confirmed')}</th>
            {hasMasqueradePermissions && (
              <th>
                <i className="bi bi-box-arrow-in-right" />
              </th>
            )}
          </tr>
        </thead>

        <tbody>
          {recruiters.map((recruiter, index) => (
            // eslint-disable-next-line react/no-array-index-key
            <tr key={index}>
              <td>{recruiter.id}</td>
              <td className="image-cell">
                <span>
                  {recruiter.email}
                  {recruiter.profile_picture_url && (
                    <img src={recruiter.profile_picture_url} alt="Profile" className="ms-3 rounded-circle" />
                  )}
                </span>
              </td>
              <td>{recruiter.created_at}</td>
              <td>{recruiter['confirmed?'] ? i18n.t('general.yes') : i18n.t('general.no') }</td>
              {hasMasqueradePermissions && (
                <td>
                  <a href={`${recruiter.sign_in_path}?resource_id=${recruiter.id}`}>
                    {i18n.t('devise.shared.links.sign_in')}
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

Recruiters.propTypes = {
  hasMasqueradePermissions: PropTypes.bool.isRequired
};

export default Recruiters;
