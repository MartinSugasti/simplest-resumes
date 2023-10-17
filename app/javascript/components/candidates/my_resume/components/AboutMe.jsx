import React, { useState } from 'react';

import { exampleAboutMe } from '../constants';

const AboutMe = () => {
  const [value, setValue] = useState('');
  const [editing, setEditing] = useState(false);

  const editInput = () => {
    setEditing(true);
  };

  const handleChange = (event) => {
    setValue(event.target.value);
  };

  const inputFocusOut = () => {
    setEditing(false);
  };

  let valueElement;
  if (editing) {
    valueElement = (
      <textarea
        className="bg-light border-0 w-100 py-0 no-outline"
        rows="5"
        value={value}
        onChange={handleChange}
        onBlur={inputFocusOut}
        // eslint-disable-next-line jsx-a11y/no-autofocus
        autoFocus
      />
    );
  } else {
    valueElement = value;
  }

  return (
    <div className="card-body py-0">
      <h3 className="mt-3 mb-0 text-md-start">
        About Me

        <span role="button" onClick={editInput} tabIndex="0" onKeyDown={editInput}>
          <i className="bi bi-pencil-square fa-xs ms-2" />
        </span>
      </h3>

      {(value || editing) ? (
        <p className="mt-2 mb-0 text-md-start">{valueElement}</p>
      ) : (
        <p className="mt-2 mb-0 text-md-start fst-italic text-black-50">{exampleAboutMe}</p>
      )}
    </div>
  );
};

export default AboutMe;
