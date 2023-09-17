import React, { useEffect } from 'react';
import { ToastContainer, toast } from 'react-toastify';

import { postCheckout } from './api';

const Payments = () => {
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
      showSucessToast('Order placed! You will receive an email confirmation.');
    }

    if (query.get('canceled')) {
      showErrorToast("Order canceled -- continue to shop around and checkout when you're ready.");
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
          Make a US$5 payment
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
