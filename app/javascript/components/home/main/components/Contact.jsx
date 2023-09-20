import React, { useRef } from 'react';
import { ToastContainer, toast } from 'react-toastify';
import ReCAPTCHA from 'react-google-recaptcha';

import PrivacyPolicy from './PrivacyPolicy';

import sendContactForm from '../api';
import { GOOGLE_RECAPTCHA_SITE_KEY } from '../constants';

const Contact = () => {
  const recaptchaRef = useRef();

  const toastConfig = {
    position: 'bottom-left',
    autoClose: 5000,
    hideProgressBar: false,
    closeOnClick: true,
    pauseOnHover: false,
    draggable: true,
    progress: undefined,
    theme: 'light'
  };

  const showSucessToast = (message) => toast.success(message, toastConfig);
  const showErrorToast = () => toast.error('Something went wrong. Please, try again later!', toastConfig);

  const enableContactFormButton = () => {
    document.querySelector('#contact-form-button').disabled = false;
  };
  const disableContactFormButton = () => {
    document.querySelector('#contact-form-button').disabled = true;
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    disableContactFormButton();

    const data = {
      name: event.target.name.value,
      email: event.target.email.value,
      mobile: event.target.mobile.value,
      query: event.target.query.value,
      recaptcha: recaptchaRef.current.getValue()
    };

    sendContactForm(data)
      .then((response) => {
        event.target.reset();
        showSucessToast(response.data);
      }).catch((error) => {
        console.log(error);
        showErrorToast();
      }).finally(() => recaptchaRef.current.reset());
  };

  return (
    <section id="contact" className="bg-white">
      <div className="container-lg py-5">
        <div className="text-center">
          <h1 className="text-dark mb-0">Contact</h1>
          <p className="text-dark mb-2 fst-italic">Send us your message and we will be in touch soon!</p>
        </div>

        <div className="row mx-0 justify-content-center mt-4 mt-md-5">
          <div className="col-sm-10 col-md-8 col-xl-6">
            <form id="contact-form" className="contact-form-dark" onSubmit={handleSubmit}>
              <div className="input-group mb-3">
                <span className="input-group-text">
                  <i className="bi bi-person-fill text-dark" />
                </span>
                <input
                  type="text"
                  name="name"
                  id="name"
                  className="form-control bg-light"
                  placeholder="Name"
                  required
                />
              </div>

              <div className="mb-3 input-group">
                <span className="input-group-text">
                  <i className="bi bi-envelope-fill text-dark" />
                </span>
                <input
                  type="email"
                  name="email"
                  id="email"
                  className="form-control text-dark bg-light"
                  placeholder="Email"
                  required
                />
              </div>

              <div className="mb-3 input-group">
                <span className="input-group-text">
                  <i className="bi bi-phone-fill text-dark" />
                </span>
                <input
                  type="text"
                  pattern="[0-9]+"
                  name="mobile"
                  id="mobile"
                  className="form-control text-dark bg-light"
                  placeholder="Contact number"
                />
              </div>

              <div className="mb-3 form-floating">
                <textarea
                  className="form-control text-dark bg-light"
                  id="query"
                  name="query"
                  style={{ height: '140px' }}
                  placeholder="Write your message.."
                  required
                />
                <label htmlFor="query">Write your message...</label>
              </div>

              <ReCAPTCHA
                sitekey={GOOGLE_RECAPTCHA_SITE_KEY}
                ref={recaptchaRef}
                onChange={enableContactFormButton}
                onExpired={disableContactFormButton}
                className="d-flex justify-content-center"
                size={window.innerWidth < 400 ? 'compact' : 'normal'}
                hl="en"
              />

              <div className="text-center mt-4">
                <button
                  id="contact-form-button"
                  type="submit"
                  className="btn btn-outline-primary-dark rounded-pill w-25"
                  disabled
                >
                  Submit
                </button>

                {/* Modal is in PrivacyPolicy component */}
                <a
                  href="#contact-form"
                  className="privacy-policy-link"
                  alt="privacy-policy"
                  data-bs-toggle="modal"
                  data-bs-target="#privacy-policy-modal"
                >
                  <p className="small text-dark fst-italic mt-1">Privacy Policy</p>
                </a>
              </div>
            </form>
          </div>
        </div>

        <PrivacyPolicy />

        <ToastContainer
          position="bottom-left"
          autoClose={5000}
          hideProgressBar={false}
          newestOnTop={false}
          closeOnClick
          rtl={false}
          pauseOnFocusLoss
          draggable
          pauseOnHover={false}
          theme="light"
        />
      </div>
    </section>
  );
};

export default Contact;
