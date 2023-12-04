import React from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

const ErrorPage = ({ message }) => {
  const { t } = useTranslation();

  return (
    <div className="align-items-center d-flex justify-content-center my-5 py-5">
      <div id="error-page" className="text-center text-dark">
        <h2 className="mb-1">Oops!</h2>
        <p className="mb-1">{t('general.unexpected_error')}</p>
        <p className="mb-0">
          <i>{message}</i>
        </p>
      </div>
    </div>
  );
};

ErrorPage.propTypes = {
  message: PropTypes.string
};

ErrorPage.defaultProps = {
  message: 'Unknown error'
};

export default ErrorPage;
