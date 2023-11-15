/* eslint-disable react/no-array-index-key */
import React from 'react';
import PropTypes from 'prop-types';

import { connect } from 'react-redux';
import { addItem, removeItem } from '../store/actions';

import EducationModal from './EducationModal';
import { exampleEducationItems } from '../constants';

const Education = ({ items, onItemAddition, onItemRemoval }) => (
  <div className="card-body py-0">
    <h3 className="mt-3 mb-0 text-md-start">
      Education

      <span role="button">
        <i
          className="bi bi-plus-circle fa-xs ms-2"
          data-bs-toggle="modal"
          data-bs-target="#newEducationItemModal"
        />
      </span>
    </h3>

    {items.length > 0 ? (
      items.map((item, index) => (
        <div key={index} id={index} className="row align-items-center text-md-start mt-2">
          <p className="col-12 col-md-4 mb-0 fw-bold">
            {item.name}
            <span
              role="button"
              onClick={() => onItemRemoval(index)}
              tabIndex="0"
              onKeyDown={() => onItemRemoval(index)}
            >
              <i className="bi bi-trash fa-sm ms-2" />
            </span>
          </p>
          <p className="col-12 col-md-5 mb-0">{item.institute}</p>
          <p className="col-12 col-md-3 mb-0 fw-bold text-md-end">
            {item.start_year}
            {' - '}
            {item.end_year ? item.end_year : 'Present'}
          </p>
        </div>
      ))
    ) : (
      exampleEducationItems.map((item, index) => (
        <div
          key={index}
          id={index}
          className="row align-items-center text-md-start mt-2 fst-italic text-black-50"
        >
          <p className="col-12 col-md-4 mb-0 fw-bold">
            {item.name}
          </p>
          <p className="col-12 col-md-5 mb-0">{item.institute}</p>
          <p className="col-12 col-md-3 mb-0 fw-bold text-md-end">
            {item.start_year}
            {' - '}
            {item.end_year ? item.end_year : 'Present'}
          </p>
        </div>
      ))
    )}

    <EducationModal addItem={onItemAddition} />
  </div>
);

const mapStateToProps = (state) => ({
  items: state.educationItems.items
});

const mapDispatchToProps = (dispatch) => ({
  onItemAddition: (item) => {
    dispatch(addItem('educationItems', item));
  },
  onItemRemoval: (index) => {
    dispatch(removeItem('educationItems', index));
  }
});

Education.propTypes = {
  items: PropTypes.arrayOf(
    PropTypes.shape({})
  ),
  onItemAddition: PropTypes.func.isRequired,
  onItemRemoval: PropTypes.func.isRequired
};

Education.defaultProps = {
  items: []
};

export default connect(mapStateToProps, mapDispatchToProps)(Education);
