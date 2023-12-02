import React, { useEffect } from 'react';
import {
  useLoaderData,
  Form,
  useOutletContext,
  useParams,
  redirect,
  useSubmit,
  useNavigate,
  useActionData
} from 'react-router-dom';

import { editJobPosting, createJobPosting, updateJobPosting } from '../api';
import { showErrorToast, showSuccessToast } from '../../../shared/Toaster';

export const newLoader = ({ request, params }) => {

  return { jobPosting: {} };
}

export const editLoader = async ({ params }) => {
  const response = await editJobPosting(params.id);

  return { jobPosting: response.data };
};

export const createAction = async ({ request }) => {
  const formData = await request.formData();
  const formParams = Object.fromEntries(formData);

  try {
    await createJobPosting({ job_posting: formParams });
    showSuccessToast('Job Posting successfully created!');

    return redirect('/recruiters/job_postings');
  } catch (error) {
    const errorMessage = error.response?.data?.errors || error.message;
    showErrorToast(errorMessage);

    return { errors: error.response?.data?.errors };
  }
};

export const updateAction = async ({ request, params }) => {
  const formData = await request.formData();
  const formParams = Object.fromEntries(formData);

  try {
    await updateJobPosting(params.id, { job_posting: formParams });
    showSuccessToast('Job Posting successfully updated!');

    return redirect('/recruiters/job_postings');
  } catch (error) {
    const errorMessage = error.response?.data?.errors || error.message;
    showErrorToast(errorMessage);

    return { errors: error.response?.data?.errors };
  }
};

const JobPostingForm = () => {
  const { jobPosting } = useLoaderData();
  const [setBreadcrumbs] = useOutletContext();
  const { id } = useParams();
  const submit = useSubmit();
  const navigate = useNavigate();
  const data = useActionData();

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
        <button
          type="button"
          className="border-0 btn m-0 p-0 text-decoration-underline text-primary"
          onClick={() => navigate(-1)}
        >
          Back
        </button>
      </div>

      <Form method="post">
        <div className="mb-3">
          <label htmlFor="title" className="form-label">Title</label>

          <input
            type="text"
            className={`form-control ${data?.errors?.title ? 'is-invalid' : '' }`}
            id="title"
            name="title"
            defaultValue={jobPosting.title}
            required
          />

          {data?.errors?.title && (
            <div className="invalid-feedback">
              {`Title ${data?.errors?.title[0]}`}
            </div>
          )}
        </div>

        <div className="mb-3">
          <label htmlFor="company" className="form-label">Company</label>

          <input
            type="text"
            className={`form-control ${data?.errors?.company ? 'is-invalid' : '' }`}
            id="company"
            name="company"
            defaultValue={jobPosting.company}
          />

          {data?.errors?.company && (
            <div className="invalid-feedback">
              {`Company ${data?.errors?.company[0]}`}
            </div>
          )}
        </div>

        <div className="mb-3">
          <label htmlFor="skills" className="form-label">Skills</label>

          <input
            type="text"
            className={`form-control ${data?.errors?.skills ? 'is-invalid' : '' }`}
            id="skills"
            name="skills"
            defaultValue={jobPosting.skills}
          />

          {data?.errors?.skills && (
            <div className="invalid-feedback">
              {`Skills ${data?.errors?.skills[0]}`}
            </div>
          )}
        </div>

        <div className="mb-3">
          <label htmlFor="description" className="form-label">Description</label>

          <textarea
            className={`form-control ${data?.errors?.description ? 'is-invalid' : '' }`}
            id="description"
            name="description"
            rows="3"
            defaultValue={jobPosting.description}
          />

          {data?.errors?.description && (
            <div className="invalid-feedback">
              {`Description ${data?.errors?.description[0]}`}
            </div>
          )}
        </div>

        <div className="mb-3 form-check">
          <input type="hidden" value={false} name="published" />
          <input
            type="checkbox"
            className={`form-check-input ${data?.errors?.published ? 'is-invalid' : '' }`}
            id="published"
            name="published"
            defaultChecked={jobPosting.published}
          />

          <label className="form-check-label" htmlFor="published">
            Publish?
          </label>

          {data?.errors?.published && (
            <div className="invalid-feedback">
              {`Publish ${data?.errors?.published[0]}`}
            </div>
          )}
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
