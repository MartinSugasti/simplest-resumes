import React from 'react';
import PropTypes from 'prop-types';

const ReferenceModal = ({ title, addItem }) => {
  function handleSubmit(event) {
    event.preventDefault();

    // create item and add it to the items list
    const newItem = {
      fullName: document.getElementById(`new-${title}-reference-fullName`).value,
      mobile: document.getElementById(`new-${title}-reference-mobile`).value,
      company: document.getElementById(`new-${title}-reference-company`).value,
      position: document.getElementById(`new-${title}-reference-position`).value,
    };
    addItem(newItem);

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
                {title}
                {' '}
                Reference
              </h3>
              <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" />
            </div>

            <div className="modal-body">
              <div className="form-group row mb-3">
                <label
                  htmlFor={`new-${title}-reference-fullName`}
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  Full Name:
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id={`new-${title}-reference-fullName`}
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor={`new-${title}-reference-mobile`}
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  Mobile:
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
                  Company:
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
                  Position:
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
              <button type="submit" className="btn btn-primary text-light" data-bs-dismiss="modal" aria-label="Close">
                Add
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
  addItem: PropTypes.func
};

ReferenceModal.defaultProps = {
  title: '',
  addItem: () => {}
};

export default ReferenceModal;
