// I created this component because of issues
// with Link component from react routes and Navbar from bootstrap
// It shows loader when necessary
// It scrolls to top when necessary
// It scrolls to element with sectionId when necessary
// It closes Navbar when necessary

import React from 'react';
import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import * as bootstrap from 'bootstrap';

const LinkWithLoaderAndScrolling = ({
  to,
  className,
  sectionId,
  children
}) => {
  const showLoader = (id) => {
    const section = document.getElementById(id);

    // If section is not found, it means we are navigating to a new path,
    // so loader should show up
    if (!section) {
      document.querySelector('#loader').classList.remove('hidden');
      document.querySelector('#home').classList.remove('non-hidden');

      setTimeout(() => {
        document.querySelector('#loader').classList.add('hidden');
        document.querySelector('#home').classList.add('non-hidden');
      }, 1500);
    }

    // If id contains the word 'intro', it means we are navigating to a top section,
    // so page should scroll to top
    if (id.includes('intro')) {
      console.log('Scrolling up');
      window.scrollTo(0, 0);
    }

    // If id contains the word 'contacto', it means we are navigating to the contact form,
    // so page should scroll to that section
    // A 1 sec timeout is set in case the contact form is not in current page
    if (id.includes('contacto')) {
      if (section) {
        document.querySelector('#contacto').scrollIntoView();
      } else {
        setTimeout(() => {
          document.querySelector('#contacto').scrollIntoView();
        }, 1000);
      }
    }

    // Close navbar in case it's open
    const menuToggle = document.querySelector('#main-nav.show');
    if (menuToggle) {
      const bsCollapse = new bootstrap.Collapse(menuToggle);
      bsCollapse.toggle();
    }
  };

  return (
    <Link to={to} className={className} onClick={() => showLoader(sectionId)}>
      {children}
    </Link>
  );
};

LinkWithLoaderAndScrolling.propTypes = {
  to: PropTypes.string.isRequired,
  className: PropTypes.string,
  sectionId: PropTypes.string.isRequired,
  children: PropTypes.node.isRequired
};

LinkWithLoaderAndScrolling.defaultProps = {
  className: null
};

export default LinkWithLoaderAndScrolling;
