import React from 'react';
import PropTypes from 'prop-types';

const SkillModal = ({ addSkill }) => {
  function handleSubmit(event) {
    event.preventDefault();

    const name = document.getElementById('new-skill-name').value;
    const kind = document.getElementById('new-skill-kind').value;
    addSkill(name, kind);

    // next is to clean form
    document.getElementById('new-skill-name').value = '';
    document.getElementById('new-skill-kind').value = 'primary';

    // next is to hide modal
    const modal = document.getElementById('newSkillModal');
    modal.classList.remove('show');
    modal.setAttribute('aria-hidden', 'true');
    modal.setAttribute('style', 'display: none');
    const modalsBackdrops = document.getElementsByClassName('modal-backdrop');
    for (let i = 0; i < modalsBackdrops.length; i += 1) {
      document.body.removeChild(modalsBackdrops[i]);
    }
    document.body.classList.remove('modal-open');
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
              <h3 className="modal-title w-100">Skill</h3>
              <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" />
            </div>

            <div className="modal-body">
              <div className="form-group row mb-3">
                <label
                  htmlFor="new-skill-name"
                  className="col-form-label col-12 col-sm-4 text-sm-end me-2"
                >
                  Skill:
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
                  Kind:
                </label>
                <div className="col-12 col-sm-6">
                  <select className="form-control" id="new-skill-kind" required="required">
                    <option value="primary">Primary</option>
                    <option value="secondary">Secondary</option>
                  </select>
                </div>
              </div>
            </div>

            <div className="modal-footer justify-content-center">
              <button type="submit" className="btn btn-primary text-light">
                Add
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
};

SkillModal.propTypes = {
  addSkill: PropTypes.func
};

SkillModal.defaultProps = {
  addSkill: () => {}
};

export default SkillModal;
