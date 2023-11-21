/* eslint-disable react/no-array-index-key */
import React from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

import { connect } from 'react-redux';
import { createItem, destroyItem } from '../store/actions';

import SkillModal from './SkillModal';
import { examplePrimarySkills, exampleSecondarySkills } from '../constants';

const Skills = ({
  resumeId,
  primarySkills,
  secondarySkills,
  onItemAddition,
  onItemRemoval
}) => {
  const { t } = useTranslation();

  return (
    <div className="card-body py-0">
      <h3 className="mt-3 mb-0 text-md-start">
        {t('candidates.my_resume.show.skills')}

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
                onClick={() => onItemRemoval('primary', item.id)}
                tabIndex="0"
                onKeyDown={() => onItemRemoval('primary', item.id)}
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
                onClick={() => onItemRemoval('secondary', item.id)}
                tabIndex="0"
                onKeyDown={() => onItemRemoval('secondary', item.id)}
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

      <SkillModal resumeId={resumeId} createItem={onItemAddition} />
    </div>
  );
};

const mapStateToProps = (state) => ({
  primarySkills: state.primarySkillItems.items,
  secondarySkills: state.secondarySkillItems.items
});

const mapDispatchToProps = (dispatch) => ({
  onItemAddition: (skillType, item) => {
    dispatch(createItem(`${skillType}SkillItem`, item));
  },
  onItemRemoval: (skillType, id) => {
    dispatch(destroyItem(`${skillType}SkillItem`, id));
  }
});

Skills.propTypes = {
  resumeId: PropTypes.number,
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
  resumeId: null,
  primarySkills: [],
  secondarySkills: []
};

export default connect(mapStateToProps, mapDispatchToProps)(Skills);
