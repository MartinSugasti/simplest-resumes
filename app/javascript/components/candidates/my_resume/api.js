import axios from '../../shared/configuredAxios';

export const getResume = () => {
  const response = axios.get('/candidates/my_resume.json');

  return response;
};

export const updateResume = (params) => {
  const response = axios.put('/candidates/my_resume.json', { resume: params });

  return response;
};

export const postItem = (itemType, params) => {
  const response = axios.post(`/candidates/${itemType}s.json`, params);

  return response;
};

export const deleteItem = (itemType, id) => {
  const response = axios.delete(`/candidates/${itemType}s/${id}.json`);

  return response;
};
