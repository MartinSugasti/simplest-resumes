import React, { useState } from 'react';

import EducationModal from './EducationModal';
import { exampleEducationItems } from '../constants';

const Education = () => {
  const [items, setItems] = useState([]);

  const addItem = (item) => {
    setItems([...items, item]);
  };

  const removeItem = (indexToRemove) => {
    setItems(items.filter((_, index) => index !== indexToRemove));
  };

  return (
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
          <div key={item.degree} id={index} className="row align-items-center text-md-start mt-2">
            <p className="col-12 col-md-4 mb-0 fw-bold">
              {item.degree}
              <span role="button" onClick={() => removeItem(index)} tabIndex="0" onKeyDown={() => removeItem(index)}>
                <i className="bi bi-trash fa-sm ms-2" />
              </span>
            </p>
            <p className="col-12 col-md-5 mb-0">{item.school}</p>
            <p className="col-12 col-md-3 mb-0 fw-bold text-md-end">
              {item.startDate}
              {' - '}
              {item.endDate ? item.endDate : 'Present'}
            </p>
          </div>
        ))
      ) : (
        exampleEducationItems.map((item, index) => (
          <div
            key={item.degree}
            id={index}
            className="row align-items-center text-md-start mt-2 fst-italic text-black-50"
          >
            <p className="col-12 col-md-4 mb-0 fw-bold">
              {item.degree}
            </p>
            <p className="col-12 col-md-5 mb-0">{item.school}</p>
            <p className="col-12 col-md-3 mb-0 fw-bold text-md-end">
              {item.startDate}
              {' - '}
              {item.endDate ? item.endDate : 'Present'}
            </p>
          </div>
        ))
      )}

      <EducationModal addItem={addItem} />
    </div>
  );
};

export default Education;
