import React from 'react';
import PropTypes from 'prop-types';
import { Modal } from 'bootstrap';
import { useTranslation } from 'react-i18next';

const WorkExperienceModal = ({ resumeId, createItem }) => {
  const { t } = useTranslation();

  function handleSubmit(event) {
    event.preventDefault();

    // create item and add it to the items list
    const startDate = document.getElementById('new-work-experience-item-start-date').value;
    const startYearMonth = startDate.split('-');
    const endDate = document.getElementById('new-work-experience-item-end-date').value;
    const endYearMonth = endDate.split('-');

    const newItem = {
      resume_id: resumeId,
      position: document.getElementById('new-work-experience-item-position').value,
      company: document.getElementById('new-work-experience-item-company').value,
      location: document.getElementById('new-work-experience-item-location').value,
      start_month: startYearMonth[1],
      start_year: startYearMonth[0],
      end_month: endYearMonth[1],
      end_year: endYearMonth[0],
      description: document.getElementById('new-work-experience-item-description').value
    };
    createItem(newItem);

    const modalElement = document.querySelector('#newWorkExperienceItemModal');
    const modal = Modal.getInstance(modalElement);
    modal.hide();

    document.getElementById('newWorkExperienceItemForm').reset();
  }

  return (
    <div
      className="modal fade"
      id="newWorkExperienceItemModal"
      tabIndex="-1"
      aria-labelledby="newWorkExperienceItem"
      aria-hidden="true"
    >
      <div className="modal-dialog modal-dialog-centered">
        <div className="modal-content text-dark">
          <form id="newWorkExperienceItemForm" onSubmit={handleSubmit}>
            <div className="modal-header text-center">
              <h3 className="modal-title w-100">{t('candidates.my_resume.show.work_experience')}</h3>
              <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" />
            </div>

            <div className="modal-body">
              <div className="form-group row mb-3">
                <label
                  htmlFor="new-work-experience-item-position"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.position')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-work-experience-item-position"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor="new-work-experience-item-company"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.company')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-work-experience-item-company"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor="new-work-experience-item-start-date"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.start')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="month"
                    className="form-control"
                    id="new-work-experience-item-start-date"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor="new-work-experience-item-end-date"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.end')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="month"
                    className="form-control"
                    id="new-work-experience-item-end-date"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor="new-work-experience-item-location"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.location')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-work-experience-item-location"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row">
                <label
                  htmlFor="new-work-experience-item-description"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.description')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <textarea
                    className="form-control"
                    id="new-work-experience-item-description"
                    rows="5"
                    required="required"
                  />
                </div>
              </div>
            </div>

            <div className="modal-footer justify-content-center">
              <button type="submit" className="btn btn-primary text-light">
                {t('candidates.my_resume.show.add')}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
};

WorkExperienceModal.propTypes = {
  resumeId: PropTypes.number,
  createItem: PropTypes.func
};

WorkExperienceModal.defaultProps = {
  resumeId: null,
  createItem: () => {}
};

export default WorkExperienceModal;
