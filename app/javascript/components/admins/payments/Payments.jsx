import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';

import Loader from '../../shared/Loader';
import { getPayments } from './api';

const Payments = () => {
  const [payments, setPayments] = useState([]);
  const { t } = useTranslation();

  useEffect(() => {
    getPayments().then((response) => {
      setPayments(response.data);
    }).catch((error) => console.log(error));
  }, []);

  return (
    <div className="table-responsive" id="admins-payments-report">
      {payments.length === 0 ? (
        <div className="align-items-center d-flex justify-content-center my-5 py-5"><Loader /></div>
      ) : (
        <table className="table table-striped text-center mb-0">
          <thead>
            <tr>
              <th>{t('activerecord.attributes.payment.stripe_id')}</th>
              <th>{t('activerecord.attributes.payment.amount')}</th>
              <th>{t('activerecord.attributes.payment.candidate')}</th>
              <th>{t('activerecord.attributes.payment.status')}</th>
              <th>{t('activerecord.attributes.payment.created_at')}</th>
            </tr>
          </thead>

          <tbody>
            {payments.map((payment) => (
              <tr key={payment.stripe_id}>
                <td className="align-middle">{payment.stripe_id}</td>
                <td className="align-middle">
                  €
                  {' '}
                  {payment.amount}
                </td>
                <td className="align-middle">{payment.candidate_email}</td>
                <td className="align-middle">{payment.status}</td>
                <td className="align-middle">{payment.created_at}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

export default Payments;
