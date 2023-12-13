import React from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

import { connect } from 'react-redux';
import { createItem, destroyItem } from '../store/actions';

import ExternalLinkModal from './ExternalLinkModal';
import { exampleExternalLinks } from '../constants';

const ExternalLinks = ({
  resumeId,
  externalLinks,
  onItemAddition,
  onItemRemoval
}) => {
  const { t } = useTranslation();

  return (
    <div className="card-body py-0">
      <h3 className="mt-3 mb-0 text-md-start">
        {t('candidates.my_resume.show.external_links')}

        <span role="button">
          <i
            className="bi bi-plus-circle fa-xs ms-2"
            data-bs-toggle="modal"
            data-bs-target="#newExternalLinkModal"
          />
        </span>
      </h3>

      {externalLinks.length > 0 ? (
        externalLinks.map((item) => (
          <div key={item.id} id={item.id} className="fst-italic mt-2">
            <p className="mb-0">
              <span className="fw-bold">{item.name}</span>
              {' - '}
              {item.url}

              <span
                role="button"
                onClick={() => onItemRemoval(item.id)}
                tabIndex="0"
                onKeyDown={() => onItemRemoval(item.id)}
              >
                <i className="bi bi-trash fa-sm ms-1" />
              </span>
            </p>
          </div>
        ))
      ) : (
        exampleExternalLinks.map((item) => (
          <div key={item.id} id={item.id} className="fst-italic text-black-50 mt-2">
            <p className="mb-0">
              <span className="fw-bold">{item.name}</span>
              {' - '}
              {item.url}
            </p>
          </div>
        ))
      )}

      <ExternalLinkModal resumeId={resumeId} createItem={onItemAddition} />
    </div>
  );
};

const mapStateToProps = (state) => ({
  externalLinks: state.externalLinkItems.items
});

const mapDispatchToProps = (dispatch) => ({
  onItemAddition: (item) => {
    dispatch(createItem('externalLinkItem', item));
  },
  onItemRemoval: (id) => {
    dispatch(destroyItem('externalLinkItem', id));
  }
});

ExternalLinks.propTypes = {
  resumeId: PropTypes.number,
  externalLinks: PropTypes.arrayOf(
    PropTypes.shape({})
  ),
  onItemAddition: PropTypes.func.isRequired,
  onItemRemoval: PropTypes.func.isRequired
};

ExternalLinks.defaultProps = {
  resumeId: null,
  externalLinks: []
};

export default connect(mapStateToProps, mapDispatchToProps)(ExternalLinks);
