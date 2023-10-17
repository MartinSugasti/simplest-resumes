import React, { useState } from 'react';
import PropTypes from 'prop-types';

import ReferenceModal from './ReferenceModal';

const SpecificReferences = ({ title, exampleReferences }) => {
  const [references, setReferences] = useState([]);

  const addItem = (item) => {
    setReferences([...references, item]);
  };

  const removeItem = (indexToRemove) => {
    setReferences(references.filter((_, index) => index !== indexToRemove));
  };

  return (
    <div className="col-12 col-md-6 mt-3 text-md-start">
      <h3>
        {title}
        {' '}
        References

        <span role="button">
          <i
            className="bi bi-plus-circle fa-xs ms-2"
            data-toggle="modal"
            data-target={`#new${title}ReferenceModal`}
          />
        </span>
      </h3>

      {references.length > 0 ? (
        references.map((item, index) => (
          <div key={item.fullName} id={index} className="row mt-2 align-items-center">
            <p className="col-12 col-md-6 mb-0 fw-bold">
              {item.fullName}
              <span
                role="button"
                onClick={() => removeItem(index)}
                tabIndex="0"
                onKeyDown={() => removeItem(index)}
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
          <div key={item.fullName} id={index} className="row mt-2 align-items-center fst-italic text-black-50">
            <p className="col-12 col-md-6 mb-0 fw-bold">
              {item.fullName}
              <span
                role="button"
                onClick={() => removeItem(index)}
                tabIndex="0"
                onKeyDown={() => removeItem(index)}
              >
                <i className="bi bi-trash fa-sm ms-2" />
              </span>
            </p>
            <p className="col-12 col-md-5 mb-0 fw-bold text-md-start">{item.mobile}</p>
            <p className="col-12 col-md-6 mb-0">{item.company}</p>
            <p className="col-12 col-md-6 mb-0 text-md-start">{item.position}</p>
          </div>
        ))
      )}

      <ReferenceModal title={title} addItem={addItem} />
    </div>
  );
};

SpecificReferences.propTypes = {
  title: PropTypes.string,
  exampleReferences: PropTypes.arrayOf(
    PropTypes.shape({})
  )
};

SpecificReferences.defaultProps = {
  title: '',
  exampleReferences: []
};

export default SpecificReferences;
