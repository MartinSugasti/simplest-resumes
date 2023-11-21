import React from 'react';
import PropTypes from 'prop-types';
import { Modal } from 'bootstrap';
import { useTranslation } from 'react-i18next';

const SkillModal = ({ resumeId, createItem }) => {
  const { t } = useTranslation();

  function handleSubmit(event) {
    event.preventDefault();

    const name = document.getElementById('new-skill-name').value;
    const kind = document.getElementById('new-skill-kind').value;
    createItem(kind, { resume_id: resumeId, name, kind });

    const modalElement = document.querySelector('#newSkillModal');
    const modal = Modal.getInstance(modalElement);
    modal.hide();

    document.getElementById('newSkillForm').reset();
  }

  return (
    <div
      className="modal fade"
      id="newSkillModal"
      tabIndex="-1"
      aria-labelledby="newSkill"
      aria-hidden="true"
    >
      <div className="modal-dialog modal-dialog-centered">
        <div className="modal-content text-dark">
          <form id="newSkillForm" onSubmit={handleSubmit}>
            <div className="modal-header text-center">
              <h3 className="modal-title w-100">{t('candidates.my_resume.show.skill')}</h3>
              <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" />
            </div>

            <div className="modal-body">
              <div className="form-group row mb-3">
                <label
                  htmlFor="new-skill-name"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.name')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-skill-name"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row">
                <label
                  htmlFor="new-skill-kind"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.kind')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <select className="form-control" id="new-skill-kind" required="required">
                    <option value="primary">{t('candidates.my_resume.show.primary')}</option>
                    <option value="secondary">{t('candidates.my_resume.show.secondary')}</option>
                  </select>
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

SkillModal.propTypes = {
  resumeId: PropTypes.number,
  createItem: PropTypes.func
};

SkillModal.defaultProps = {
  resumeId: null,
  createItem: () => {}
};

export default SkillModal;
