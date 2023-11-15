/* eslint-disable react/no-array-index-key */
import React from 'react';
import PropTypes from 'prop-types';

import { connect } from 'react-redux';
import { addItem, removeItem } from '../store/actions';

import SkillModal from './SkillModal';
import { examplePrimarySkills, exampleSecondarySkills } from '../constants';

const Skills = ({
  primarySkills,
  secondarySkills,
  onItemAddition,
  onItemRemoval
}) => {
  const addSkill = (name, type) => {
    onItemAddition(type, name);
  };

  const removeSkill = (index, type) => {
    onItemRemoval(type, index);
  };

  return (
    <div className="card-body py-0">
      <h3 className="mt-3 mb-0 text-md-start">
        Skills

        <span role="button">
          <i
            className="bi bi-plus-circle fa-xs ms-2"
            data-bs-toggle="modal"
            data-bs-target="#newSkillModal"
          />
        </span>
      </h3>

      <div className="d-md-flex text-md-start mt-2">
        {primarySkills.length > 0 ? (
          primarySkills.map((item, index) => (
            <div key={index} id={index} className="d-flex align-items-center fw-bold">
              <p className="mb-0">
                {item.name}
              </p>

              <span
                role="button"
                onClick={() => removeSkill(index, 'primary')}
                tabIndex="0"
                onKeyDown={() => removeSkill(index, 'primary')}
              >
                <i className="bi bi-trash fa-sm ms-1" />
              </span>

              {primarySkills.length !== index + 1 && (
                <span className="d-none d-md-inline mx-1">-</span>
              )}
            </div>
          ))
        ) : (
          examplePrimarySkills.map((item, index) => (
            <div key={index} id={index} className="d-flex align-items-center fw-bold fst-italic text-black-50">
              <p className="mb-0">
                {item.name}
              </p>

              {examplePrimarySkills.length !== index + 1 && (
                <span className="d-none d-md-inline mx-1">-</span>
              )}
            </div>
          ))
        )}
      </div>

      <div className="d-md-flex text-md-start mt-2">
        {secondarySkills.length > 0 ? (
          secondarySkills.map((item, index) => (
            <div key={index} id={index} className="d-flex align-items-center">
              <p className="mb-0">
                {item.name}
              </p>

              <span
                role="button"
                onClick={() => removeSkill(index, 'secondary')}
                tabIndex="0"
                onKeyDown={() => removeSkill(index, 'secondary')}
              >
                <i className="bi bi-trash fa-sm ms-1" />
              </span>

              {secondarySkills.length !== index + 1 && (
                <span className="d-none d-md-inline mx-1">-</span>
              )}
            </div>
          ))
        ) : (
          exampleSecondarySkills.map((item, index) => (
            <div key={index} id={index} className="d-flex align-items-center fst-italic text-black-50">
              <p className="mb-0">
                {item.name}
              </p>

              {exampleSecondarySkills.length !== index + 1 && (
                <span className="d-none d-md-inline mx-1">-</span>
              )}
            </div>
          ))
        )}
      </div>

      <SkillModal addSkill={addSkill} />
    </div>
  );
};

const mapStateToProps = (state) => ({
  primarySkills: state.primarySkillsItems.items,
  secondarySkills: state.secondarySkillsItems.items
});

const mapDispatchToProps = (dispatch) => ({
  onItemAddition: (skillType, item) => {
    dispatch(addItem(`${skillType}SkillsItems`, item));
  },
  onItemRemoval: (skillType, index) => {
    dispatch(removeItem(`${skillType}SkillsItems`, index));
  }
});

Skills.propTypes = {
  primarySkills: PropTypes.arrayOf(
    PropTypes.shape({})
  ),
  secondarySkills: PropTypes.arrayOf(
    PropTypes.shape({})
  ),
  onItemAddition: PropTypes.func.isRequired,
  onItemRemoval: PropTypes.func.isRequired
};

Skills.defaultProps = {
  primarySkills: [],
  secondarySkills: []
};

export default connect(mapStateToProps, mapDispatchToProps)(Skills);
