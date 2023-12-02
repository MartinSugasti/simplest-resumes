import axios from '../../shared/configuredAxios';

export const getJobPostings = () => axios.get('/candidates/job_postings.json');

export const getJobPosting = (id) => axios.get(`/candidates/job_postings/${id}.json`);
