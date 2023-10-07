import React, { useLayoutEffect, useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { useLocation } from 'react-router-dom';
import { useTranslation } from 'react-i18next';

import LinkWithLoaderAndScrolling from './LinkWithLoaderAndScrolling';

import lightLogo from '../../../images/logos/light.png';
import darkLogo from '../../../images/logos/dark.png';

const useWindowSize = () => {
  const [size, setSize] = useState([0, 0]);

  useLayoutEffect(() => {
    const updateSize = () => setSize([window.innerWidth, window.innerHeight]);
    window.addEventListener('resize', updateSize);
    updateSize();
    return () => window.removeEventListener('resize', updateSize);
  }, []);

  return size;
};

const Navbar = ({ signInAvailable }) => {
  // eslint-disable-next-line no-unused-vars
  const [width, _height] = useWindowSize();
  const [scrolled, setScrolled] = useState(false);
  const { pathname } = useLocation();

  const { t, i18n } = useTranslation();

  const applyLightBg = width >= 768 || scrolled || pathname.includes('about');
  const classForLinks = `btn btn-link nav-link m-auto text-${applyLightBg ? 'dark' : 'light'} fs-6`;

  useEffect(() => {
    const updateClass = () => {
      if (document.body.scrollTop >= 400 || document.documentElement.scrollTop >= 400) {
        setScrolled(true);
      } else {
        setScrolled(false);
      }
    };
    window.addEventListener('scroll', updateClass);

    return () => window.removeEventListener('scroll', updateClass);
  }, [width]);

  return (
    <nav
      id="signed-out-navbar"
      className={
        `navbar sticky-top navbar-expand-md pt-2 pb-2
        ${applyLightBg ? 'light-bg navbar-light' : 'colored-bg navbar-dark'}
        ${scrolled ? 'shadow-lg' : ''}`
      }
    >
      <div className="container-xxl">
        <a className="navbar-brand" href="/home">
          <img src={applyLightBg ? darkLogo : lightLogo} className="img-fluid logo" alt="logo" />
        </a>

        <button
          className="navbar-toggler border-0"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#main-nav"
          aria-controls="main-nav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span className="navbar-toggler-icon" />
        </button>

        <div className="collapse navbar-collapse justify-content-end align-center" id="main-nav">
          <ul className="navbar-nav">
            <LinkWithLoaderAndScrolling to="/home" className={classForLinks} sectionId="main-intro">
              {t('pages.navbar.home')}
            </LinkWithLoaderAndScrolling>

            <LinkWithLoaderAndScrolling to="/about" className={classForLinks} sectionId="about-us-intro">
              {t('pages.navbar.about_us')}
            </LinkWithLoaderAndScrolling>

            <LinkWithLoaderAndScrolling to="/home#contact" className={classForLinks} sectionId="contact">
              {t('pages.navbar.contact')}
            </LinkWithLoaderAndScrolling>

            {signInAvailable ? (
              <a href={`/candidates/sign_in?lang=${i18n.resolvedLanguage}`} className={classForLinks}>
                {t('pages.navbar.sign_in')}
              </a>
            ) : (
              <a href="/" className={classForLinks}>
                {t('pages.navbar.dashboard')}
              </a>
            )}

            {signInAvailable && (
              <div className="d-flex languages">
                <button
                  type="button"
                  onClick={() => i18n.changeLanguage('en')}
                  className={`${classForLinks} pe-1 ${i18n.resolvedLanguage === 'en' ? 'fw-semibold' : ''}`}
                >
                  {t('general.languages.abbreviations.en')}
                </button>

                <hr className="m-0 border-1" />

                <button
                  type="button"
                  onClick={() => i18n.changeLanguage('es')}
                  className={`${classForLinks} ps-1 ${i18n.resolvedLanguage === 'es' ? 'fw-semibold' : ''}`}
                >
                  {t('general.languages.abbreviations.es')}
                </button>
              </div>
            )}
          </ul>
        </div>
      </div>
    </nav>
  );
};

Navbar.propTypes = {
  signInAvailable: PropTypes.bool
};

Navbar.defaultProps = {
  signInAvailable: false
};

export default Navbar;
