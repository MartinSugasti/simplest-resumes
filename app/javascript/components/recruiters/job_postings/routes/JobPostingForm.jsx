import React, { useEffect } from 'react';
import {
  useLoaderData,
  Form,
  Link,
  useOutletContext,
  useParams,
  redirect,
  useSubmit
} from 'react-router-dom';

import { editJobPosting, createJobPosting, updateJobPosting } from '../api';

export const newLoader = () => ({ jobPosting: {} });

export const editLoader = async ({ params }) => {
  const response = await editJobPosting(params.id);

  return { jobPosting: response.data };
};

export const createAction = async ({ request }) => {
  const formData = await request.formData();
  const formParams = Object.fromEntries(formData);
  await createJobPosting({ job_posting: formParams });

  return redirect('/recruiters/job_postings');
};

export const updateAction = async ({ request, params }) => {
  const formData = await request.formData();
  const formParams = Object.fromEntries(formData);

  await updateJobPosting(params.id, { job_posting: formParams });

  return redirect('/recruiters/job_postings');
};

export const destroyAction = async ({ request, params }) => {
  const formData = await request.formData();
  const formParams = Object.fromEntries(formData);

  await updateJobPosting(params.id, { job_posting: formParams });

  return redirect('/recruiters/job_postings');
};

const JobPostingForm = () => {
  const { jobPosting } = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const { id } = useParams();
  const submit = useSubmit();

  useEffect(() => {
    let breadcrumbs;
    if (id) {
      breadcrumbs = 'Job Postings / <strong>Edit</strong>';
    } else {
      breadcrumbs = 'Job Postings / <strong>New</strong>';
    }

    setBreadcrumbs(breadcrumbs);
  }, []);

  return (
    <>
      <div className="mb-3">
        <Link to="/recruiters/job_postings" className="text-primary">
          Back
        </Link>
      </div>

      <Form method="post">
        <div className="mb-3">
          <label htmlFor="title" className="form-label">Title</label>
          <input
            type="text"
            className="form-control"
            id="title"
            name="title"
            defaultValue={jobPosting.title}
            required
          />
        </div>

        <div className="mb-3">
          <label htmlFor="company" className="form-label">Company</label>
          <input type="text" className="form-control" id="company" name="company" defaultValue={jobPosting.company} />
        </div>

        <div className="mb-3">
          <label htmlFor="skills" className="form-label">Skills</label>
          <input type="text" className="form-control" id="skills" name="skills" defaultValue={jobPosting.skills} />
        </div>

        <div className="mb-3">
          <label htmlFor="description" className="form-label">Description</label>
          <textarea
            className="form-control"
            id="description"
            name="description"
            rows="3"
            defaultValue={jobPosting.description}
          />
        </div>

        <div className="mb-3 form-check">
          <input type="hidden" value={false} name="published" />
          <input
            type="checkbox"
            className="form-check-input"
            id="published"
            name="published"
            defaultChecked={jobPosting.published}
          />
          <label className="form-check-label" htmlFor="published">
            Publish?
          </label>
        </div>

        <button type="submit" className="btn btn-primary text-light">Save</button>
        {id && (
          <button
            type="button"
            onClick={() => {
              // eslint-disable-next-line no-restricted-globals
              if (confirm('Please confirm you want to delete this record.')) {
                submit(null, {
                  method: 'delete',
                  action: `/recruiters/job_postings/${id}/destroy`
                });
              }
            }}
            className="btn btn-danger ms-3"
          >
            Delete
          </button>
        )}
      </Form>
    </>
  );
};

export default JobPostingForm;
