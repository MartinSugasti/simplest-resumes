import React, { useEffect } from 'react';
import { useTranslation } from 'react-i18next';

import Toaster, { showErrorToast, showSuccessToast } from '../../shared/Toaster';

import { postCheckout } from './api';

const Payments = () => {
  const { t } = useTranslation();

  useEffect(() => {
    // Check to see if this is a redirect back from Checkout
    const query = new URLSearchParams(window.location.search);

    if (query.get('success')) {
      showSuccessToast(t('candidates.payments.index.checkout_success'));
    }

    if (query.get('canceled')) {
      showErrorToast(t('candidates.payments.index.checkout_canceled'));
    }
  }, [t]);

  const handleSubmit = (event) => {
    event.preventDefault();

    postCheckout().then((response) => {
      window.location.href = response.data.url;
    });
  };

  return (
    <>
      <form onSubmit={handleSubmit}>
        <button type="submit" className="btn-submit btn btn-primary border-0 shadow w-100 text-light rounded-pill">
          {t('candidates.payments.index.make_5_dollars_payment')}
        </button>
      </form>

      <Toaster />
    </>
  );
};

export default Payments;
