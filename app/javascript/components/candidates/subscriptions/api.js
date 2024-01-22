import axios from '../../shared/configuredAxios';

export const postSubscription = (planId) => {
  const response = axios.post('/candidates/subscriptions.json', { plan_id: planId });

  return response;
};

export const getPlans = () => {
  const response = axios.get('/candidates/subscriptions/prices.json');

  return response;
};
