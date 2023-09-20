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
              href="mailto:martinsugasti@gmail.com"
              className="email-link text-light"
              target="_blank"
              rel="noreferrer"
            >
              <i className="bi bi-envelope-fill me-2" />
              martinsugasti@gmail.com
            </a>
          </p>
          <p className="text-light mb-1">
            <a
              href="https://wa.me/696924288"
              className="mobile-link text-light"
              target="_blank"
              rel="noreferrer"
            >
              <i className="bi bi-phone me-2" />
              +34 696 924 288
            </a>
          </p>
        </div>

        <div className="text-light align-self-end mt-4 mt-sm-1">
          <a
            href="https://www.linkedin.com/in/martin-sugasti-ab2aa391/"
            alt="link-to-linkedin"
            target="_blank"
            rel="noreferrer"
          >
            <i className="text-light bi bi-linkedin fa-2x me-3 me-md-4" />
          </a>
          <a
            href="https://www.instagram.com/martinsugastisanchez/"
            alt="link-to-instagram"
            target="_blank"
            rel="noreferrer"
          >
            <i className="text-light bi bi-instagram fa-2x me-3 me-md-4" />
          </a>
          <a
            href="https://twitter.com/MartinSugasti"
            alt="link-to-twitter"
            target="_blank"
            rel="noreferrer"
          >
            <i className="text-light bi bi-twitter fa-2x me-3 me-md-4" />
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
