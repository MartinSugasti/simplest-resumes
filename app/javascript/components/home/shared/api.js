import axios from '../../shared/configuredAxios';

const sendContactForm = (data) => {
  const response = axios.post('/contact_form.json', { contact_form: data });

  return response;
};

export default sendContactForm;
