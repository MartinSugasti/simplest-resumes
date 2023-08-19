// I created this component because of issues with Link component from react routes.
// It scrolls to top when necessary
// And scroll to element with sectionId when necessary

import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { HashLink } from 'react-router-hash-link';
import { useLocation } from 'react-router-dom';

const LinkWithLoaderAndScrolling = ({
  to,
  className,
  sectionId,
  children
}) => {
  const { pathname } = useLocation();

  useEffect(() => window.scrollTo(0, 0), [pathname]);

  const showLoader = (id) => {
    const section = document.getElementById(id);

    if (section) {
      if (id.includes('intro')) {
        window.scrollTo(0, 0);
      }
    } else {
      document.querySelector('#loader').classList.remove('hidden');
      document.querySelector('#home').classList.remove('non-hidden');

      setTimeout(() => {
        document.querySelector('#loader').classList.add('hidden');
        document.querySelector('#home').classList.add('non-hidden');
      }, 1500);
    }
  };

  return (
    <HashLink to={to} className={className} role="button" onClick={() => showLoader(sectionId)}>
      {children}
    </HashLink>
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
