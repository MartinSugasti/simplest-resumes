import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';

import { getCandidates } from './api';

const Candidates = ({ currentUser }) => {
  const [candidates, setCandidates] = useState([]);

  useEffect(() => {
    getCandidates().then((response) => {
      setCandidates(response.data);
    }).catch((error) => console.log(error));
  }, []);

  return (
    <div className="table-responsive">
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
          {candidates.map((candidate, index) => (
            // eslint-disable-next-line react/no-array-index-key
            <tr key={index}>
              <td>{candidate.id}</td>
              <td>{candidate.email}</td>
              <td>{candidate.created_at}</td>
              <td>{candidate['confirmed?'] ? 'Yes' : 'No' }</td>
              {currentUser.role === 'super_admin' && (
                <td>
                  <a href={`${candidate.sign_in_path}?resource_id=${candidate.id}`}>Sign In</a>
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
  currentUser: PropTypes.shape({
    role: PropTypes.string
  }).isRequired
};

export default Candidates;
