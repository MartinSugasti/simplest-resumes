import React, { useLayoutEffect, useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { useLocation } from 'react-router-dom';

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

const Navbar = ({ userSignedIn }) => {
  // eslint-disable-next-line no-unused-vars
  const [width, _height] = useWindowSize();
  const [scrolled, setScrolled] = useState(false);
  const { pathname } = useLocation();

  const applyLightBg = width >= 768 || scrolled || pathname.includes('about') || pathname.includes('cotizacion');
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
      id="navbar"
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

        <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main-nav" aria-controls="main-nav" aria-expanded="false" aria-label="Toggle navigation">
          <span className="navbar-toggler-icon" />
        </button>

        <div className="collapse navbar-collapse justify-content-end align-center" id="main-nav">
          <ul className="navbar-nav">
            <LinkWithLoaderAndScrolling to="/home" className={classForLinks} sectionId="main-intro">
              INICIO
            </LinkWithLoaderAndScrolling>

            <LinkWithLoaderAndScrolling to="/cotizacion" className={classForLinks} sectionId="cotizacion-intro">
              COTIZAR
            </LinkWithLoaderAndScrolling>

            <LinkWithLoaderAndScrolling to="/about" className={classForLinks} sectionId="about-us-intro">
              NOSOTROS
            </LinkWithLoaderAndScrolling>

            <LinkWithLoaderAndScrolling to="/home#contacto" className={classForLinks} sectionId="contacto">
              CONTACTO
            </LinkWithLoaderAndScrolling>

            {userSignedIn ? (
              <a href="/" className={classForLinks}>
                DASHBOARD
              </a>
            ) : (
              <a href="/users/sign_in" className={classForLinks}>
                LOG IN
              </a>
            )}
          </ul>
        </div>
      </div>
    </nav>
  );
};

Navbar.propTypes = {
  userSignedIn: PropTypes.bool
};

Navbar.defaultProps = {
  userSignedIn: false
};

export default Navbar;
