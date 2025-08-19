import axios from '../../shared/configuredAxios';

export const getJobPostings = (query) => {
  const params = {};

  if (query) {
    params.query = query;
  }
  return axios.get('/candidates/job_postings.json', { params });
};

export const getJobPosting = (id) => axios.get(`/candidates/job_postings/${id}.json`);

export const createPostulation = (params) => axios.post('/candidates/postulations.json', params);
