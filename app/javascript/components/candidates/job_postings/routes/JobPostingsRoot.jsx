/* eslint-disable react/jsx-no-useless-fragment */
import React, { useState, useEffect } from 'react';
import { Outlet, useNavigation } from 'react-router-dom';

import Loader from '../../../shared/Loader/Loader';

const JobPostingsRoot = () => {
  const [breadcrumbs, setBreadcrumbs] = useState('Job Postings');
  const navigation = useNavigation();

  useEffect(() => {
    document.getElementById('top-section-breadcrumbs').innerHTML = breadcrumbs;
  }, [breadcrumbs]);

  return (
    <>
      {navigation.state === 'loading' ? (
        <div className="align-items-center d-flex justify-content-center my-5 py-5"><Loader /></div>
      ) : (
        <Outlet context={[setBreadcrumbs]} />
      )}
    </>
  );
};

export default JobPostingsRoot;
