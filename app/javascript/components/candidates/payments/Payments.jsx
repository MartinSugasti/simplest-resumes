import React, { useEffect } from 'react';
import { ToastContainer, toast } from 'react-toastify';
import { useTranslation } from 'react-i18next';

import { postCheckout } from './api';

const Payments = () => {
  const { t } = useTranslation();

  useEffect(() => {
    // Check to see if this is a redirect back from Checkout
    const query = new URLSearchParams(window.location.search);

    const toastConfig = {
      position: 'bottom-left',
      autoClose: 5000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: false,
      draggable: true,
      progress: undefined,
      theme: 'light'
    };

    const showSucessToast = (message) => toast.success(message, toastConfig);
    const showErrorToast = (message) => toast.error(message, toastConfig);

    if (query.get('success')) {
      showSucessToast(t('candidates.payments.index.checkout_success'));
    }

    if (query.get('canceled')) {
      showErrorToast(t('candidates.payments.index.checkout_canceled'));
    }
  }, []);

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

      <ToastContainer
        position="bottom-left"
        autoClose={5000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover={false}
        theme="light"
      />
    </>
  );
};

export default Payments;
