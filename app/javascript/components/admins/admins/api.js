import axios from '../../shared/configuredAxios';

// eslint-disable-next-line import/prefer-default-export
export const getAdmins = () => {
  const response = axios.get('/admins/admins.json');

  return response;
};
