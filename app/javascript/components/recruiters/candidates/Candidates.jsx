import React from 'react';
import { createBrowserRouter, RouterProvider } from 'react-router-dom';

import CandidatesRoot from './routes/CandidatesRoot';
import CandidatesList, { loader as listLoader } from './routes/CandidatesList';
import Candidate, { loader as showLoader } from './routes/Candidate';
// import { destroyAction } from './routes/JobPostingDestroy';
import RouterErrorPage from '../../shared/RouterErrorPage';
import Toaster from '../../shared/Toaster';

const router = createBrowserRouter([
  {
    path: '/recruiters/candidates',
    element: <CandidatesRoot />,
    errorElement: <RouterErrorPage />,
    children: [
      {
        index: true,
        element: <CandidatesList />,
        loader: listLoader
      },
      {
        path: '/recruiters/candidates/:id',
        element: <Candidate />,
        loader: showLoader
      },
      // {
      //   path: '/recruiters/job_postings/:id/destroy',
      //   action: destroyAction
      // }
    ]
  }
]);

const Candidates = () => (
  <>
    <RouterProvider router={router} />
    <Toaster />
  </>
);

export default Candidates;
