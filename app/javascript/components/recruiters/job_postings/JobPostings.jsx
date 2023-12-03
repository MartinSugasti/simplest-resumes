import React from 'react';
import { createBrowserRouter, RouterProvider } from 'react-router-dom';

import JobPostingsRoot from './routes/JobPostingsRoot';
import JobPostingsList, { loader as listLoader } from './routes/JobPostingsList';
import JobPosting, { loader as showLoader } from './routes/JobPosting';
import JobPostingForm, {
  newLoader,
  editLoader,
  createAction,
  updateAction
} from './routes/JobPostingForm';
import { destroyAction } from './routes/JobPostingDestroy';
import { action as approveAction } from './routes/PostulationApprove';
import { action as rejectAction } from './routes/PostulationReject';
import RouterErrorPage from '../../shared/RouterErrorPage';
import Toaster from '../../shared/Toaster';

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
        action: createAction,
        shouldRevalidate: () => false
      },
      {
        path: '/recruiters/job_postings/:id',
        element: <JobPosting />,
        loader: showLoader
      },
      {
        path: '/recruiters/job_postings/:id/edit',
        element: <JobPostingForm />,
        loader: editLoader,
        action: updateAction,
        shouldRevalidate: () => false
      },
      {
        path: '/recruiters/job_postings/:id/destroy',
        action: destroyAction
      },
      {
        path: '/recruiters/job_postings/:id/postulations/:postulationId/approve',
        action: approveAction
      },
      {
        path: '/recruiters/job_postings/:id/postulations/:postulationId/reject',
        action: rejectAction
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
