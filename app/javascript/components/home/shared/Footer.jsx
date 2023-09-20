import React from 'react';

import LinkWithLoaderAndScrolling from './LinkWithLoaderAndScrolling';

import lightLogo from '../../../images/logos/light.png';

const Footer = () => (
  <section id="footer" className="bg-dark">
    <div className="container-lg pt-5 pb-3">
      <div className="d-sm-flex justify-content-between mx-3 mx-lg-0">
        <div>
          <p className="text-light mb-1">
            <a
              href="mailto:info@urseseguros.com.uy"
              className="email-link text-light"
              target="_blank"
              rel="noreferrer"
            >
              <i className="bi bi-envelope-fill me-2" />
              info@urseseguros.com.uy
            </a>
          </p>
          <p className="text-light mb-1">
            <a
              href="https://wa.me/59899804290"
              className="mobile-link text-light"
              target="_blank"
              rel="noreferrer"
            >
              <i className="bi bi-phone me-2" />
              099804290
            </a>
          </p>
        </div>

        <div className="text-light align-self-end mt-4 mt-sm-1">
          <a
            href="https://www.linkedin.com/company/urse-seguros/"
            alt="link-to-urseseguros-linkedin"
            target="_blank"
            rel="noreferrer"
          >
            <i className="text-light bi bi-linkedin fa-2x me-3 me-md-4" />
          </a>
          <a
            href="https://www.instagram.com/urse_seguros/"
            alt="link-to-urseseguros-instagram"
            target="_blank"
            rel="noreferrer"
          >
            <i className="text-light bi bi-instagram fa-2x me-3 me-md-4" />
          </a>
          <a
            href="https://twitter.com/UrseSeguros"
            alt="link-to-urseseguros-twitter"
            target="_blank"
            rel="noreferrer"
          >
            <i className="text-light bi bi-twitter fa-2x me-3 me-md-4" />
          </a>
          <a
            href="https://www.facebook.com/ursesegurosflorida"
            alt="link-to-urseseguros-facebook"
            target="_blank"
            rel="noreferrer"
          >
            <i className="text-light bi bi-facebook fa-2x me-3 me-md-4" />
          </a>
        </div>
      </div>

      <div className="text-center mt-4 pt-3 mx-3 mx-lg-0 border-top">
        <LinkWithLoaderAndScrolling to="/home" className="btn btn-link col-6 col-sm-3 col-md-2" sectionId="main-intro">
          <img src={lightLogo} className="img-fluid logo" alt="main-logo" />
        </LinkWithLoaderAndScrolling>
      </div>
    </div>
  </section>
);

export default Footer;
