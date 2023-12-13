import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';

import { getAdmins } from './api';

const Admins = () => {
  const [admins, setAdmins] = useState([]);
  const { t } = useTranslation();

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
            <th>{t('activerecord.attributes.admin.email')}</th>
            <th>{t('activerecord.attributes.admin.role')}</th>
            <th>{t('activerecord.attributes.admin.created_at')}</th>
            <th>{t('activerecord.attributes.admin.invited_by')}</th>
            <th>{t('activerecord.attributes.admin.invitation_accepted')}</th>
            <th>{t('activerecord.attributes.admin.admins_invited')}</th>
          </tr>
        </thead>

        <tbody>
          {admins.map((admin) => (
            <tr key={admin.id}>
              <td className="align-middle">{admin.id}</td>
              <td className="align-middle">{admin.email}</td>
              <td className="align-middle">{admin.role}</td>
              <td className="align-middle">{admin.created_at}</td>
              <td className="align-middle">{admin.invited_by}</td>
              <td className="align-middle">{admin.invitation_accepted}</td>
              <td className="align-middle">{admin.admins_invited}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Admins;
