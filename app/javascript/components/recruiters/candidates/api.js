import axios from '../../shared/configuredAxios';

export const getCandidates = (query) => {
  const params = {};

  if (query) {
    params.query = query;
  }
  return axios.get('/recruiters/candidates.json', { params });
};

export const getCandidate = (id) => axios.get(`/recruiters/candidates/${id}.json`);

export const getResume = (id) => axios.get(`/recruiters/resumes/${id}.json`);
