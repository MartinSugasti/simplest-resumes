import React from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

import { connect } from 'react-redux';
import { createItem, destroyItem } from '../store/actions';

import EducationModal from './EducationModal';
import { exampleEducationItems } from '../constants';

const Education = ({
  resumeId,
  items,
  onItemAddition,
  onItemRemoval
}) => {
  const { t } = useTranslation();

  return (
    <div className="card-body py-0">
      <h3 className="mt-3 mb-0 text-md-start">
        {t('candidates.my_resume.show.education')}

        <span role="button">
          <i
            className="bi bi-plus-circle fa-xs ms-2"
            data-bs-toggle="modal"
            data-bs-target="#newEducationItemModal"
          />
        </span>
      </h3>

      {items.length > 0 ? (
        items.map((item) => (
          <div key={item.id} id={item.id} className="row align-items-center text-md-start mt-2">
            <p className="col-12 col-md-4 mb-0 fw-bold">
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
            <p className="col-12 col-md-5 mb-0">{item.institute}</p>
            <p className="col-12 col-md-3 mb-0 fw-bold text-md-end">
              {item.start_year}
              {' - '}
              {item.end_year ? item.end_year : t('candidates.my_resume.show.present')}
            </p>
          </div>
        ))
      ) : (
        exampleEducationItems.map((item) => (
          <div
            key={item.id}
            id={item.id}
            className="row align-items-center text-md-start mt-2 fst-italic text-black-50"
          >
            <p className="col-12 col-md-4 mb-0 fw-bold">
              {item.name}
            </p>
            <p className="col-12 col-md-5 mb-0">{item.institute}</p>
            <p className="col-12 col-md-3 mb-0 fw-bold text-md-end">
              {item.start_year}
              {' - '}
              {item.end_year ? item.end_year : t('candidates.my_resume.show.present')}
            </p>
          </div>
        ))
      )}

      <EducationModal resumeId={resumeId} createItem={onItemAddition} />
    </div>
  );
};

const mapStateToProps = (state) => ({
  items: state.educationItems.items
});

const mapDispatchToProps = (dispatch) => ({
  onItemAddition: (item) => {
    dispatch(createItem('educationItem', item));
  },
  onItemRemoval: (id) => {
    dispatch(destroyItem('educationItem', id));
  }
});

Education.propTypes = {
  resumeId: PropTypes.number,
  items: PropTypes.arrayOf(
    PropTypes.shape({})
  ),
  onItemAddition: PropTypes.func.isRequired,
  onItemRemoval: PropTypes.func.isRequired
};

Education.defaultProps = {
  resumeId: null,
  items: []
};

export default connect(mapStateToProps, mapDispatchToProps)(Education);
