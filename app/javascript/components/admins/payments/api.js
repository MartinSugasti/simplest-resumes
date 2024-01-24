import axios from '../../shared/configuredAxios';

// eslint-disable-next-line import/prefer-default-export
export const getPayments = () => {
  const response = axios.get('/admins/payments.json');

  return response;
};
