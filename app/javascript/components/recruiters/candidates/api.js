import axios from '../../shared/configuredAxios';

export const getCandidates = () => axios.get('/recruiters/candidates.json');

export const getCandidate = (id) => axios.get(`/recruiters/candidates/${id}.json`);

export const getResume = (id) => axios.get(`/recruiters/resumes/${id}.json`);
