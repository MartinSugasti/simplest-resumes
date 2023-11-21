/* eslint-disable react/no-array-index-key */
import React from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

import { connect } from 'react-redux';
import { createItem, destroyItem } from '../store/actions';

import ReferenceModal from './ReferenceModal';

const SpecificReferences = ({
  title,
  resumeId,
  exampleReferences,
  items,
  onItemAddition,
  onItemRemoval
}) => {
  const { t } = useTranslation();

  return (
    <div className="col-12 col-md-6 mt-3 text-md-start">
      <h3>
        {t(`candidates.my_resume.show.${title}_references`)}

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
                onClick={() => onItemRemoval(item.id)}
                tabIndex="0"
                onKeyDown={() => onItemRemoval(item.id)}
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

      <ReferenceModal title={title} resumeId={resumeId} createItem={onItemAddition} />
    </div>
  );
};

const mapStateToProps = (state, ownProps) => ({
  items: state[`${ownProps.title}ReferenceItems`].items
});

const mapDispatchToProps = (dispatch, ownProps) => ({
  onItemAddition: (item) => {
    dispatch(createItem(`${ownProps.title}ReferenceItem`, item));
  },
  onItemRemoval: (id) => {
    dispatch(destroyItem(`${ownProps.title}ReferenceItem`, id));
  }
});

SpecificReferences.propTypes = {
  title: PropTypes.string,
  resumeId: PropTypes.number,
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
  resumeId: null,
  exampleReferences: [],
  items: []
};

export default connect(mapStateToProps, mapDispatchToProps)(SpecificReferences);
