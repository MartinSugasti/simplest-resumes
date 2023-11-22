import React from 'react';
import PropTypes from 'prop-types';
import { Modal } from 'bootstrap';
import { useTranslation } from 'react-i18next';

const ReferenceModal = ({ title, resumeId, createItem }) => {
  const { t } = useTranslation();

  function handleSubmit(event) {
    event.preventDefault();

    // create item and add it to the items list
    const newItem = {
      resume_id: resumeId,
      kind: title,
      name: document.getElementById(`new-${title}-reference-name`).value,
      mobile: document.getElementById(`new-${title}-reference-mobile`).value,
      company: document.getElementById(`new-${title}-reference-company`).value,
      position: document.getElementById(`new-${title}-reference-position`).value
    };
    createItem(title, newItem);

    const modalElement = document.querySelector(`#new${title}ReferenceModal`);
    const modal = Modal.getInstance(modalElement);
    modal.hide();

    document.getElementById(`new${title}ReferenceForm`).reset();
  }

  return (
    <div
      className="modal fade"
      id={`new${title}ReferenceModal`}
      tabIndex="-1"
      aria-labelledby={`new${title}Reference`}
      aria-hidden="true"
    >
      <div className="modal-dialog modal-dialog-centered">
        <div className="modal-content text-dark">
          <form id={`new${title}ReferenceForm`} onSubmit={handleSubmit}>
            <div className="modal-header text-center">
              <h3 className="modal-title w-100">
                {t(`candidates.my_resume.show.${title}_reference`)}
              </h3>
              <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" />
            </div>

            <div className="modal-body">
              <div className="form-group row mb-3">
                <label
                  htmlFor={`new-${title}-reference-name`}
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.full_name')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id={`new-${title}-reference-name`}
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor={`new-${title}-reference-mobile`}
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.mobile')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id={`new-${title}-reference-mobile`}
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor={`new-${title}-reference-company`}
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.company')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id={`new-${title}-reference-company`}
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row">
                <label
                  htmlFor={`new-${title}-reference-position`}
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  {`${t('candidates.my_resume.show.position')}:`}
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id={`new-${title}-reference-position`}
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

ReferenceModal.propTypes = {
  title: PropTypes.string,
  resumeId: PropTypes.number,
  createItem: PropTypes.func
};

ReferenceModal.defaultProps = {
  title: '',
  resumeId: null,
  createItem: () => {}
};

export default ReferenceModal;
