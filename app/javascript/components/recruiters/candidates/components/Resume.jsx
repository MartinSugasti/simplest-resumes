import React from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

const Resume = ({ resumeData }) => {
  const { t } = useTranslation();

  return (
    <div className="card py-3 border-2 text-dark">
      <div className="card-body text-center py-0">
        {resumeData.name && (
          <h1 className="mb-0">
            {resumeData.name}
          </h1>
        )}

        <div className="row mt-2 justify-content-around">
          {resumeData.email && (
            <span className="col-12 col-md-4 card-text">
              <i className="bi bi-envelope-at" />
              <br />
              {resumeData.email}
            </span>
          )}

          {resumeData.mobile && (
            <span className="col-12 col-md-4 card-text mt-2 mt-md-0">
              <i className="bi bi-phone" />
              <br />
              {resumeData.mobile}
            </span>
          )}

          {resumeData.location && (
            <span className="col-12 col-md-4 card-tex mt-2 mt-md-0">
              <i className="bi bi-geo-alt" />
              <br />
              {resumeData.location}
            </span>
          )}
        </div>
      </div>

      {resumeData.about_me && (
        <div className="card-body py-0">
          <h3 className="mt-3 mb-0 text-md-start">
            {t('candidates.my_resume.show.about_me')}
          </h3>

          <p className="mt-2 mb-0 text-md-start">{resumeData.about_me}</p>
        </div>
      )}

      {resumeData.education_items && (
        <div className="card-body py-0">
          <h3 className="mt-3 mb-0 text-md-start">
            {t('candidates.my_resume.show.education')}
          </h3>

          {resumeData.education_items.map((item, index) => (
            <div key={item.id} id={index} className="row align-items-center text-md-start mt-2">
              <p className="col-12 col-md-4 mb-0 fw-bold">
                {item.name}
              </p>
              <p className="col-12 col-md-5 mb-0">{item.institute}</p>
              <p className="col-12 col-md-3 mb-0 fw-bold text-md-end">
                {item.start_year}
                {' - '}
                {item.end_year ? item.end_year : t('candidates.my_resume.show.present')}
              </p>
            </div>
          ))}
        </div>
      )}

      {resumeData.education_items && (
        <div className="card-body py-0">
          <h3 className="mt-3 mb-0 text-md-start">
            {t('candidates.my_resume.show.work_experience')}
          </h3>

          {resumeData.work_experience_items.map((item, index) => (
            <div key={item.id} id={index} className="text-md-start mt-2">
              <div className="row">
                <div className="col-12 col-md-6 align-items-center">
                  <p className="mb-0 fw-bold">
                    {item.position}
                  </p>
                  <p className="mb-0 fw-bold">{item.company}</p>
                </div>

                <div className="col-12 col-md-6 align-items-center">
                  <p className="mb-0 fw-bold text-md-end">
                    {`${item.start_month}/${item.start_year}`}
                    {' - '}
                    {item.end_year ? `${item.end_month}/${item.end_year}` : t('candidates.my_resume.show.present')}
                  </p>
                  <p className="mb-0 fw-bold text-md-end">{item.location}</p>
                </div>
              </div>

              <p className="mb-0">{item.description}</p>
            </div>
          ))}
        </div>
      )}

      {(resumeData.primary_skill_items || resumeData.secondary_skill_items) && (
        <div className="card-body py-0">
          <h3 className="mt-3 mb-0 text-md-start">
            {t('candidates.my_resume.show.skills')}
          </h3>

          {resumeData.primary_skill_items && (
            <div className="d-md-flex text-md-start mt-2">
              {resumeData.primary_skill_items.map((item, index) => (
                <div key={item.id} id={index} className="d-flex align-items-center fw-bold">
                  <p className="mb-0">
                    {item.name}
                  </p>

                  {resumeData.primary_skill_items.length !== index + 1 && (
                    <span className="d-none d-md-inline mx-1">-</span>
                  )}
                </div>
              ))}
            </div>
          )}

          {resumeData.secondary_skill_items && (
            <div className="d-md-flex text-md-start mt-2">
              {resumeData.secondary_skill_items.map((item, index) => (
                <div key={item.id} id={index} className="d-flex align-items-center">
                  <p className="mb-0">
                    {item.name}
                  </p>

                  {resumeData.secondary_skill_items.length !== index + 1 && (
                    <span className="d-none d-md-inline mx-1">-</span>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {(resumeData.personal_reference_items || resumeData.job_reference_items) && (
        <div className="card-body row py-0">
          {resumeData.personal_reference_items && (
            <div className="col-12 col-md-6 mt-3 text-md-start">
              <h3>
                {t('candidates.my_resume.show.personal_references')}
              </h3>

              {resumeData.personal_reference_items.map((item, index) => (
                <div key={item.id} id={index} className="row mt-2 align-items-center">
                  <p className="col-12 col-md-6 mb-0 fw-bold">
                    {item.name}
                  </p>
                  <p className="col-12 col-md-5 mb-0 fw-bold text-md-start">{item.mobile}</p>
                  <p className="col-12 col-md-6 mb-0">{item.company}</p>
                  <p className="col-12 col-md-6 mb-0 text-md-start">{item.position}</p>
                </div>
              ))}
            </div>
          )}

          {resumeData.job_reference_items && (
            <div className="col-12 col-md-6 mt-3 text-md-start">
              <h3>
                {t('candidates.my_resume.show.job_references')}
              </h3>

              {resumeData.job_reference_items.map((item, index) => (
                <div key={item.id} id={index} className="row mt-2 align-items-center">
                  <p className="col-12 col-md-6 mb-0 fw-bold">
                    {item.name}
                  </p>
                  <p className="col-12 col-md-5 mb-0 fw-bold text-md-start">{item.mobile}</p>
                  <p className="col-12 col-md-6 mb-0">{item.company}</p>
                  <p className="col-12 col-md-6 mb-0 text-md-start">{item.position}</p>
                </div>
              ))}
            </div>
          )}
        </div>
      )}
    </div>
  );
};

Resume.propTypes = {
  resumeData: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    email: PropTypes.string,
    mobile: PropTypes.string,
    location: PropTypes.string,
    about_me: PropTypes.string,
    education_items: PropTypes.arrayOf(PropTypes.shape({})),
    work_experience_items: PropTypes.arrayOf(PropTypes.shape({})),
    primary_skill_items: PropTypes.arrayOf(PropTypes.shape({})),
    secondary_skill_items: PropTypes.arrayOf(PropTypes.shape({})),
    personal_reference_items: PropTypes.arrayOf(PropTypes.shape({})),
    job_reference_items: PropTypes.arrayOf(PropTypes.shape({}))
  }).isRequired
};

export default Resume;
