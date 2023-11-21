import React from 'react';
import { ToastContainer, toast } from 'react-toastify';
import translations from '../../../locales/translations.json';

const Toaster = () => (
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
);

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

export const showSuccessToast = (message) => toast.success(message, toastConfig);
export const showErrorToast = (error) => {
  const lang = document.querySelector('body').dataset.locale || 'en';
  const message = error || translations[lang].general.toast.default_error_message;
  toast.error(message, toastConfig);
};

export default Toaster;
