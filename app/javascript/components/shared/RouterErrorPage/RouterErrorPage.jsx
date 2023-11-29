import React from 'react';
import { useRouteError } from 'react-router-dom';

const RouterErrorPage = () => {
  const error = useRouteError();
  // console.error(error);

  return (
    <div className="align-items-center d-flex justify-content-center my-5 py-5">
      <div id="error-page" className="text-center text-dark">
        <h2 className="mb-1">Oops!</h2>
        <p className="mb-1">Sorry, an unexpected error has occurred.</p>
        <p className="mb-0">
          <i>{error.statusText || error.message}</i>
        </p>
      </div>
    </div>
  );
};

export default RouterErrorPage;
