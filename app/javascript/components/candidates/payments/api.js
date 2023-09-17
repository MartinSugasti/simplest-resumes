import axios from '../../shared/configuredAxios';

// eslint-disable-next-line import/prefer-default-export
export const postCheckout = () => {
  const response = axios.post('/candidates/payments/checkout.json');

  return response;
};
