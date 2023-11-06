import React from 'react';
import PropTypes from 'prop-types';

const EducationModal = ({ addItem }) => {
  const handleSubmit = (event) => {
    event.preventDefault();

    // create item and add it to the items list
    const newItem = {
      degree: document.getElementById('new-education-item-degree').value,
      school: document.getElementById('new-education-item-school').value,
      startDate: document.getElementById('new-education-item-start-date').value,
      endDate: document.getElementById('new-education-item-end-date').value
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
                  htmlFor="new-education-item-degree"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  Degree:
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-education-item-degree"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor="new-education-item-school"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  School:
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="text"
                    className="form-control"
                    id="new-education-item-school"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row mb-3">
                <label
                  htmlFor="new-education-item-start-date"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  Start:
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="number"
                    className="form-control"
                    id="new-education-item-start-date"
                    min="1970"
                    max="2030"
                    step="1"
                    required="required"
                  />
                </div>
              </div>

              <div className="form-group row">
                <label
                  htmlFor="new-education-item-end-date"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  End:
                </label>
                <div className="col-12 col-sm-6">
                  <input
                    type="number"
                    className="form-control"
                    id="new-education-item-end-date"
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
