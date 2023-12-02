import React from 'react';
import PropTypes from 'prop-types';

const ErrorPage = ({ message }) => (
  <div className="align-items-center d-flex justify-content-center my-5 py-5">
    <div id="error-page" className="text-center text-dark">
      <h2 className="mb-1">Oops!</h2>
      <p className="mb-1">Sorry, an unexpected error has occurred.</p>
      <p className="mb-0">
        <i>{message}</i>
      </p>
    </div>
  </div>
);

ErrorPage.propTypes = {
  message: PropTypes.string
};

ErrorPage.defaultProps = {
  message: 'Unknown error'
};

export default ErrorPage;
