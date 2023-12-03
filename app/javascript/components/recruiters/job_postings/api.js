import axios from '../../shared/configuredAxios';

export const getJobPostings = () => axios.get('/recruiters/job_postings.json');

export const getJobPosting = (id) => axios.get(`/recruiters/job_postings/${id}.json`);

export const editJobPosting = (id) => axios.get(`/recruiters/job_postings/${id}/edit.json`);

export const createJobPosting = (params) => axios.post('/recruiters/job_postings.json', params);

export const updateJobPosting = (id, params) => axios.put(`/recruiters/job_postings/${id}.json`, params);

export const destroyJobPosting = (id) => axios.delete(`/recruiters/job_postings/${id}.json`);

export const approvePostulation = (id, postulationId) => (
  axios.post(`/recruiters/job_postings/${id}/postulations/${postulationId}/approve.json`)
);

export const rejectPostulation = (id, postulationId) => (
  axios.post(`/recruiters/job_postings/${id}/postulations/${postulationId}/reject.json`)
);
