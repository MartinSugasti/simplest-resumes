import React, { useState, useEffect } from 'react';

import { getAdmins } from './api';

const Admins = () => {
  const [admins, setAdmins] = useState([]);

  useEffect(() => {
    getAdmins().then((response) => {
      setAdmins(response.data);
    }).catch((error) => console.log(error));
  }, []);

  return (
    <div className="table-responsive">
      <table className="table table-striped text-center mb-0">
        <thead>
          <tr>
            <th>Id</th>
            <th>Email</th>
            <th>Role</th>
            <th>Created At</th>
            <th>Invited By</th>
            <th>Invitation Accepted?</th>
            <th>Admins Invited</th>
          </tr>
        </thead>

        <tbody>
          {admins.map((admin, index) => (
            // eslint-disable-next-line react/no-array-index-key
            <tr key={index}>
              <td>{admin.id}</td>
              <td>{admin.email}</td>
              <td>{admin.role}</td>
              <td>{admin.created_at}</td>
              <td>{admin.invited_by}</td>
              <td>{admin.invitation_accepted}</td>
              <td>{admin.admins_invited}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Admins;
