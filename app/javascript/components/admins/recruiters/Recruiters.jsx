import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';

import { getRecruiters } from './api';

const Recruiters = ({ currentUser }) => {
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
            <th>Email</th>
            <th>Created At</th>
            <th>Confirmed?</th>
            {currentUser.role === 'super_admin' && (
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
              <td>{recruiter['confirmed?'] ? 'Yes' : 'No' }</td>
              {currentUser.role === 'super_admin' && (
                <td>
                  <a href={`${recruiter.sign_in_path}?resource_id=${recruiter.id}`}>Sign In</a>
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
  currentUser: PropTypes.shape({
    role: PropTypes.string
  }).isRequired
};

export default Recruiters;
