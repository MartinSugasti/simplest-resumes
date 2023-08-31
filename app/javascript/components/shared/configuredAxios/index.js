import axios from 'axios';

const csrfTokenElement = document.getElementsByName('csrf-token');

if (csrfTokenElement.length) {
  axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfTokenElement[0].content;
}

export default axios;
