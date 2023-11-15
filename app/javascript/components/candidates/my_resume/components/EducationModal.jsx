import React from 'react';
import PropTypes from 'prop-types';

const EducationModal = ({ addItem }) => {
  const handleSubmit = (event) => {
    event.preventDefault();

    // create item and add it to the items list
    const newItem = {
      name: document.getElementById('new-education-item-name').value,
      institute: document.getElementById('new-education-item-institute').value,
      start_year: document.getElementById('new-education-item-start-year').value,
      end_year: document.getElementById('new-education-item-end-year').value
    };
    addItem(newItem);

    document.getElementById('newEducationItemForm').reset();
  };

  return (
    <div
      className="modal fade text-center"
      id="newEducationItemModal"
      tabIndex="-1"
      aria-labelledby="newEducationItem"
      aria-hidden="true"
    >
      <div className="modal-dialog modal-dialog-centered">
        <div className="modal-content text-dark">
          <form id="newEducationItemForm" onSubmit={handleSubmit}>
            <div className="modal-header text-center">
              <h3 className="modal-title w-100">Education</h3>
              <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" />
            </div>

            <div className="modal-body">
              <div className="form-group row mb-3">
                <label
                  htmlFor="new-education-item-name"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  Name:
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-education-item-name"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor="new-education-item-institute"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  Institute:
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-education-item-institute"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor="new-education-item-start-year"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  Start:
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="number"
                    className="form-control"
                    id="new-education-item-start-year"
                    min="1970"
                    max="2030"
                    step="1"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row">
                <label
                  htmlFor="new-education-item-end-year"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  End:
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="number"
                    className="form-control"
                    id="new-education-item-end-year"
                    min="1970"
                    max="2030"
                    step="1"
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

EducationModal.propTypes = {
  addItem: PropTypes.func
};

EducationModal.defaultProps = {
  addItem: () => {}
};

export default EducationModal;
