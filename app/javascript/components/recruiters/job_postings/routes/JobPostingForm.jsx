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
import { useTranslation } from 'react-i18next';
import translations from '../../../../locales/translations.json';

import { editJobPosting, createJobPosting, updateJobPosting } from '../api';
import { showErrorToast, showSuccessToast } from '../../../shared/Toaster';

export const newLoader = () => ({ jobPosting: {} });

export const editLoader = async ({ params }) => {
  const response = await editJobPosting(params.id);

  return { jobPosting: response.data };
};

export const createAction = async ({ request }) => {
  const formData = await request.formData();
  const formParams = Object.fromEntries(formData);

  try {
    await createJobPosting({ job_posting: formParams });
    const lang = document.querySelector('body').dataset.locale || 'en';
    const message = translations[lang].recruiters.job_postings.created;
    showSuccessToast(message);

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
    const lang = document.querySelector('body').dataset.locale || 'en';
    const message = translations[lang].recruiters.job_postings.updated;
    showSuccessToast(message);

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
  const { t } = useTranslation();

  useEffect(() => {
    let breadcrumbs;
    if (id) {
      breadcrumbs = `${t('dashboard.job_postings')} / <strong>${t('dashboard.edit')}</strong>`;
    } else {
      breadcrumbs = `${t('dashboard.job_postings')} / <strong>${t('dashboard.new')}</strong>`;
    }

    setBreadcrumbs(breadcrumbs);
  }, [setBreadcrumbs, id, t]);

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

      <Form method="post">
        <div className="mb-3">
          <label htmlFor="title" className="form-label">
            {t('activerecord.attributes.job_posting.title')}
          </label>

          <input
            type="text"
            className={`form-control ${data?.errors?.title ? 'is-invalid' : ''}`}
            id="title"
            name="title"
            defaultValue={jobPosting.title}
            required
          />

          {data?.errors?.title && (
            <div className="invalid-feedback">
              {`${t('activerecord.attributes.job_posting.title')} ${data?.errors?.title[0]}`}
            </div>
          )}
        </div>

        <div className="mb-3">
          <label htmlFor="company" className="form-label">{t('activerecord.attributes.job_posting.company')}</label>

          <input
            type="text"
            className={`form-control ${data?.errors?.company ? 'is-invalid' : ''}`}
            id="company"
            name="company"
            defaultValue={jobPosting.company}
          />

          {data?.errors?.company && (
            <div className="invalid-feedback">
              {`${t('activerecord.attributes.job_posting.company')} ${data?.errors?.company[0]}`}
            </div>
          )}
        </div>

        <div className="mb-3">
          <label htmlFor="skills" className="form-label">{t('activerecord.attributes.job_posting.skills')}</label>

          <input
            type="text"
            className={`form-control ${data?.errors?.skills ? 'is-invalid' : ''}`}
            id="skills"
            name="skills"
            defaultValue={jobPosting.skills}
          />

          {data?.errors?.skills && (
            <div className="invalid-feedback">
              {`${t('activerecord.attributes.job_posting.skills')} ${data?.errors?.skills[0]}`}
            </div>
          )}
        </div>

        <div className="mb-3">
          <label htmlFor="description" className="form-label">
            {t('activerecord.attributes.job_posting.description')}
          </label>

          <textarea
            className={`form-control ${data?.errors?.description ? 'is-invalid' : ''}`}
            id="description"
            name="description"
            rows="3"
            defaultValue={jobPosting.description}
          />

          {data?.errors?.description && (
            <div className="invalid-feedback">
              {`${t('activerecord.attributes.job_posting.description')} ${data?.errors?.description[0]}`}
            </div>
          )}
        </div>

        <div className="mb-3 form-check">
          <input type="hidden" value={false} name="published" />
          <input
            type="checkbox"
            className={`form-check-input ${data?.errors?.published ? 'is-invalid' : ''}`}
            id="published"
            name="published"
            defaultChecked={jobPosting.published}
          />

          <label className="form-check-label" htmlFor="published">
            {t('activerecord.attributes.job_posting.publish_inquiry')}
          </label>

          {data?.errors?.published && (
            <div className="invalid-feedback">
              {`${t('activerecord.attributes.job_posting.publish')} ${data?.errors?.published[0]}`}
            </div>
          )}
        </div>

        <button type="submit" className="btn btn-primary text-light">{t('general.save')}</button>
        {id && (
          <button
            type="button"
            onClick={() => {
              // eslint-disable-next-line no-restricted-globals
              if (confirm(t('general.confirm_record_deletion'))) {
                submit(null, {
                  method: 'delete',
                  action: `/recruiters/job_postings/${id}/destroy`
                });
              }
            }}
            className="btn btn-danger ms-3"
          >
            {t('general.delete')}
          </button>
        )}
      </Form>
    </>
  );
};

export default JobPostingForm;
