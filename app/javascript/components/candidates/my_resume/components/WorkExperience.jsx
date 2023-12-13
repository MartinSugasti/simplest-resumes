import React from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

import { connect } from 'react-redux';
import { createItem, destroyItem } from '../store/actions';

import WorkExperienceModal from './WorkExperienceModal';
import { exampleWorkExperienceItems } from '../constants';

const WorkExperience = ({
  resumeId,
  items,
  onItemAddition,
  onItemRemoval
}) => {
  const { t } = useTranslation();

  return (
    <div className="card-body py-0">
      <h3 className="mt-3 mb-0 text-md-start">
        {t('candidates.my_resume.show.work_experience')}

        <span role="button">
          <i
            className="bi bi-plus-circle fa-xs ms-2"
            data-bs-toggle="modal"
            data-bs-target="#newWorkExperienceItemModal"
          />
        </span>
      </h3>

      {items.length > 0 ? (
        items.map((item) => (
          <div key={item.id} id={item.id} className="text-md-start mt-2">
            <div className="row">
              <div className="col-12 col-md-6 align-items-center">
                <p className="mb-0 fw-bold">
                  {item.position}
                  <span
                    role="button"
                    onClick={() => onItemRemoval(item.id)}
                    tabIndex="0"
                    onKeyDown={() => onItemRemoval(item.id)}
                  >
                    <i className="bi bi-trash fa-sm ms-2" />
                  </span>
                </p>
                <p className="mb-0 fw-bold">{item.company}</p>
              </div>

              <div className="col-12 col-md-6 align-items-center">
                <p className="mb-0 fw-bold text-md-end">
                  {`${item.start_month}/${item.start_year}`}
                  {' - '}
                  {item.end_year ? `${item.end_month}/${item.end_year}` : t('candidates.my_resume.show.present')}
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
                  {`${item.start_month}/${item.start_year}`}
                  {' - '}
                  {item.end_year ? `${item.end_month}/${item.end_year}` : t('candidates.my_resume.show.present')}
                </p>
                <p className="mb-0 fw-bold text-md-end">{item.location}</p>
              </div>
            </div>

            <p className="mb-0">{item.description}</p>
          </div>
        ))
      )}

      <WorkExperienceModal resumeId={resumeId} createItem={onItemAddition} />
    </div>
  );
};

const mapStateToProps = (state) => ({
  items: state.workExperienceItems.items
});

const mapDispatchToProps = (dispatch) => ({
  onItemAddition: (item) => {
    dispatch(createItem('workExperienceItem', item));
  },
  onItemRemoval: (id) => {
    dispatch(destroyItem('workExperienceItem', id));
  }
});

WorkExperience.propTypes = {
  resumeId: PropTypes.number,
  items: PropTypes.arrayOf(
    PropTypes.shape({})
  ),
  onItemAddition: PropTypes.func.isRequired,
  onItemRemoval: PropTypes.func.isRequired
};

WorkExperience.defaultProps = {
  resumeId: null,
  items: []
};

export default connect(mapStateToProps, mapDispatchToProps)(WorkExperience);
