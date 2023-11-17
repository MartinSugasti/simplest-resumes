import axios from '../../shared/configuredAxios';

// eslint-disable-next-line import/prefer-default-export
export const getResume = () => {
  const response = axios.get('/candidates/my_resume.json');

  return response;
};

export const updateResume = (params) => {
  const response = axios.put('/candidates/my_resume.json', { resume: params });

  return response;
};
