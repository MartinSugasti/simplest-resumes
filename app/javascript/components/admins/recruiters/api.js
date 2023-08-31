import axios from '../../shared/configuredAxios';

// eslint-disable-next-line import/prefer-default-export
export const getRecruiters = () => {
  const response = axios.get('/admins/recruiters.json');

  return response;
};
