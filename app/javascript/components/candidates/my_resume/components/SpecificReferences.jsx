/* eslint-disable react/no-array-index-key */
import React from 'react';
import PropTypes from 'prop-types';

import { connect } from 'react-redux';
import { addItem, removeItem } from '../store/actions';

import ReferenceModal from './ReferenceModal';

const SpecificReferences = ({
  title,
  exampleReferences,
  items,
  onItemAddition,
  onItemRemoval
}) => (
  <div className="col-12 col-md-6 mt-3 text-md-start">
    <h3>
      {title.charAt(0).toUpperCase() + title.slice(1)}
      {' '}
      References

      <span role="button">
        <i
          className="bi bi-plus-circle fa-xs ms-2"
          data-bs-toggle="modal"
          data-bs-target={`#new${title}ReferenceModal`}
        />
      </span>
    </h3>

    {items.length > 0 ? (
      items.map((item, index) => (
        <div key={index} id={index} className="row mt-2 align-items-center">
          <p className="col-12 col-md-6 mb-0 fw-bold">
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
          <p className="col-12 col-md-5 mb-0 fw-bold text-md-start">{item.mobile}</p>
          <p className="col-12 col-md-6 mb-0">{item.company}</p>
          <p className="col-12 col-md-6 mb-0 text-md-start">{item.position}</p>
        </div>
      ))
    ) : (
      exampleReferences.map((item, index) => (
        <div key={index} id={index} className="row mt-2 align-items-center fst-italic text-black-50">
          <p className="col-12 col-md-6 mb-0 fw-bold">
            {item.name}
          </p>
          <p className="col-12 col-md-5 mb-0 fw-bold text-md-start">{item.mobile}</p>
          <p className="col-12 col-md-6 mb-0">{item.company}</p>
          <p className="col-12 col-md-6 mb-0 text-md-start">{item.position}</p>
        </div>
      ))
    )}

    <ReferenceModal title={title} addItem={onItemAddition} />
  </div>
);

const mapStateToProps = (state, ownProps) => ({
  items: state[`${ownProps.title}ReferencesItems`].items
});

const mapDispatchToProps = (dispatch, ownProps) => ({
  onItemAddition: (item) => {
    dispatch(addItem(`${ownProps.title}ReferencesItems`, item));
  },
  onItemRemoval: (index) => {
    dispatch(removeItem(`${ownProps.title}ReferencesItems`, index));
  }
});

SpecificReferences.propTypes = {
  title: PropTypes.string,
  exampleReferences: PropTypes.arrayOf(
    PropTypes.shape({})
  ),
  items: PropTypes.arrayOf(
    PropTypes.shape({})
  ),
  onItemAddition: PropTypes.func.isRequired,
  onItemRemoval: PropTypes.func.isRequired
};

SpecificReferences.defaultProps = {
  title: '',
  exampleReferences: [],
  items: []
};

export default connect(mapStateToProps, mapDispatchToProps)(SpecificReferences);
