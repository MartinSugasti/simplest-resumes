import React from 'react';
import { createBrowserRouter, RouterProvider } from 'react-router-dom';

import JobPostingsRoot from './routes/JobPostingsRoot';
import JobPostingsList, { loader as listLoader } from './routes/JobPostingsList';
import JobPostingForm, {
  newLoader,
  editLoader,
  createAction,
  updateAction
} from './routes/JobPostingForm';
import { destroyAction } from './routes/JobPostingDestroy';
import RouterErrorPage from '../../shared/RouterErrorPage';

const router = createBrowserRouter([
  {
    path: '/recruiters/job_postings',
    element: <JobPostingsRoot />,
    errorElement: <RouterErrorPage />,
    children: [
      {
        index: true,
        element: <JobPostingsList />,
        loader: listLoader
      },
      {
        path: '/recruiters/job_postings/new',
        element: <JobPostingForm />,
        loader: newLoader,
        action: createAction
      },
      {
        path: '/recruiters/job_postings/:id/edit',
        element: <JobPostingForm />,
        loader: editLoader,
        action: updateAction
      },
      {
        path: '/recruiters/job_postings/:id/destroy',
        action: destroyAction
      }
    ]
  }
]);

const JobPostings = () => <RouterProvider router={router} />;

export default JobPostings;
