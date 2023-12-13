import React from 'react';
import PropTypes from 'prop-types';
import { Modal } from 'bootstrap';
import { useTranslation } from 'react-i18next';

const ExternalLinkModal = ({ resumeId, createItem }) => {
  const { t } = useTranslation();

  const handleSubmit = (event) => {
    event.preventDefault();

    // create item and add it to the items list
    const newItem = {
      resume_id: resumeId,
      name: document.getElementById('new-external-link-name').value,
      url: document.getElementById('new-external-link-url').value
    };
    createItem(newItem);

    const modalElement = document.querySelector('#newExternalLinkModal');
    const modal = Modal.getInstance(modalElement);
    modal.hide();

    document.getElementById('newExternalLinkForm').reset();
  };

  return (
    <div
      className="modal fade text-center"
      id="newExternalLinkModal"
      tabIndex="-1"
      aria-labelledby="newExternalLink"
      aria-hidden="true"
    >
      <div className="modal-dialog modal-dialog-centered">
        <div className="modal-content text-dark">
          <form id="newExternalLinkForm" onSubmit={handleSubmit}>
            <div className="modal-header text-center">
              <h3 className="modal-title w-100">{t('candidates.my_resume.show.external_link')}</h3>
              <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" />
            </div>

            <div className="modal-body">
              <div className="form-group row mb-3">
                <label
                  htmlFor="new-external-link-name"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.name')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-external-link-name"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor="new-external-link-url"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.url')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-external-link-url"
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

ExternalLinkModal.propTypes = {
  resumeId: PropTypes.number,
  createItem: PropTypes.func
};

ExternalLinkModal.defaultProps = {
  resumeId: null,
  createItem: () => {}
};

export default ExternalLinkModal;
