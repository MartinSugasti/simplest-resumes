import emailjs from 'emailjs-com';

import { EMAIL_JS_SERVICE_ID, EMAIL_JS_TEMPLATES_ID, EMAIL_JS_PUBLIC_KEY } from './constants';

const sendEmailJSform = (template, data) => (
  emailjs.send(EMAIL_JS_SERVICE_ID, EMAIL_JS_TEMPLATES_ID[template], data, EMAIL_JS_PUBLIC_KEY)
);

export default sendEmailJSform;
