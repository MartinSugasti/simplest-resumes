import React from 'react';
import { createBrowserRouter, RouterProvider } from 'react-router-dom';

import JobPostingsRoot from './routes/JobPostingsRoot';
import JobPostingsList, { loader as listLoader } from './routes/JobPostingsList';
import JobPosting, { loader as showLoader } from './routes/JobPosting';
import RouterErrorPage from '../../shared/RouterErrorPage';
import Toaster from '../../shared/Toaster';

const router = createBrowserRouter([
  {
    path: '/candidates/job_postings',
    element: <JobPostingsRoot />,
    errorElement: <RouterErrorPage />,
    children: [
      {
        index: true,
        element: <JobPostingsList />,
        loader: listLoader
      },
      {
        path: '/candidates/job_postings/:id',
        element: <JobPosting />,
        loader: showLoader
      }
    ]
  }
]);

const JobPostings = () => (
  <>
    <RouterProvider router={router} />
    <Toaster />
  </>
);

export default JobPostings;
