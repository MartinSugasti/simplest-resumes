import React from 'react';
import PropTypes from 'prop-types';

import { connect } from 'react-redux';
import { addItem, removeItem } from '../store/actions';
import WorkExperienceModal from './WorkExperienceModal';
import { exampleWorkExperienceItems } from '../constants';

const WorkExperience = ({ items, onItemAddition, onItemRemoval }) => {
  const formatDate = (date) => {
    const yearMonth = date.split('-');
    return `${parseInt(yearMonth[1], 10)}/${yearMonth[0]}`;
  };

  return (
    <div className="card-body py-0">
      <h3 className="mt-3 mb-0 text-md-start">
        Work Experience

        <span role="button">
          <i
            className="bi bi-plus-circle fa-xs ms-2"
            data-bs-toggle="modal"
            data-bs-target="#newWorkExperienceItemModal"
          />
        </span>
      </h3>

      {items.length > 0 ? (
        items.map((item, index) => (
          <div key={`${item.position}-${item.company}`} id={index} className="text-md-start mt-2">
            <div className="row">
              <div className="col-12 col-md-6 align-items-center">
                <p className="mb-0 fw-bold">
                  {item.position}
                  <span
                    role="button"
                    onClick={() => onItemRemoval(index)}
                    tabIndex="0"
                    onKeyDown={() => onItemRemoval(index)}
                  >
                    <i className="bi bi-trash fa-sm ms-2" />
                  </span>
                </p>
                <p className="mb-0 fw-bold">{item.company}</p>
              </div>

              <div className="col-12 col-md-6 align-items-center">
                <p className="mb-0 fw-bold text-md-end">
                  {formatDate(item.startDate)}
                  {' - '}
                  {item.endDate ? formatDate(item.endDate) : 'Present'}
                </p>
                <p className="mb-0 fw-bold text-md-end">{item.location}</p>
              </div>
            </div>

            <p className="mb-0">{item.description}</p>
          </div>
        ))
      ) : (
        exampleWorkExperienceItems.map((item, index) => (
          <div
            key={`${item.position}-${item.company}`}
            id={index}
            className="text-md-start mt-2 fst-italic text-black-50"
          >
            <div className="row">
              <div className="col-12 col-md-6 align-items-center">
                <p className="mb-0 fw-bold">
                  {item.position}
                </p>
                <p className="mb-0 fw-bold">{item.company}</p>
              </div>

              <div className="col-12 col-md-6 align-items-center">
                <p className="mb-0 fw-bold text-md-end">
                  {formatDate(item.startDate)}
                  {' - '}
                  {item.endDate ? formatDate(item.endDate) : 'Present'}
                </p>
                <p className="mb-0 fw-bold text-md-end">{item.location}</p>
              </div>
            </div>

            <p className="mb-0">{item.description}</p>
          </div>
        ))
      )}

      <WorkExperienceModal addItem={onItemAddition} />
    </div>
  );
};

const mapStateToProps = (state) => ({
  items: state.workExperienceItems.items
});

const mapDispatchToProps = (dispatch) => ({
  onItemAddition: (item) => {
    dispatch(addItem('workExperienceItems', item));
  },
  onItemRemoval: (index) => {
    dispatch(removeItem('workExperienceItems', index));
  }
});

WorkExperience.propTypes = {
  items: PropTypes.arrayOf(
    PropTypes.shape({})
  ),
  onItemAddition: PropTypes.func.isRequired,
  onItemRemoval: PropTypes.func.isRequired
};

WorkExperience.defaultProps = {
  items: []
};

export default connect(mapStateToProps, mapDispatchToProps)(WorkExperience);
