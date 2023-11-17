import React from 'react';
import { ToastContainer, toast } from 'react-toastify';

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
export const showErrorToast = (error) => toast.error(error, toastConfig);

export default Toaster;
