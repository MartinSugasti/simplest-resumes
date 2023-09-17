import axios from '../../shared/configuredAxios';

export const getInvitationRequests = () => {
  const response = axios.get('/admins/invitation_requests.json');

  return response;
};

export const approveInvitationRequest = (email, role) => {
  const response = axios.post('/admins/invitation', { admin: { email, role } });

  return response;
};

export const dismissInvitationRequest = (id) => {
  const response = axios.post(`/admins/invitation_requests/${id}/dismiss.json`);

  return response;
};

export const banInvitationRequest = (id) => {
  const response = axios.post(`/admins/invitation_requests/${id}/ban.json`);

  return response;
};
