import axios from '../../shared/configuredAxios';

// eslint-disable-next-line import/prefer-default-export
export const getCandidates = () => {
  const response = axios.get('/admins/candidates.json');

  return response;
};
