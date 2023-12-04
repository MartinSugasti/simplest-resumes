import React from 'react';
import { useRouteError, useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';

import ErrorPage from '../ErrorPage';

const RouterErrorPage = () => {
  const error = useRouteError();
  const navigate = useNavigate();
  const { t } = useTranslation();

  return (
    <>
      <div className="mb-3">
        <button
          type="button"
          className="border-0 btn m-0 p-0 text-decoration-underline text-primary"
          onClick={() => navigate(-1)}
        >
          {t('general.back')}
        </button>
      </div>

      <ErrorPage message={error?.response?.data?.errors || error?.statusText || error?.message} />
    </>
  );
};

export default RouterErrorPage;
