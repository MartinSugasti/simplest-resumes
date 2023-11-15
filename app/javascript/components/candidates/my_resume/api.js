import axios from '../../shared/configuredAxios';

// eslint-disable-next-line import/prefer-default-export
export const getResume = () => {
  const response = axios.get('/candidates/my_resume.json');

  return response;
};
