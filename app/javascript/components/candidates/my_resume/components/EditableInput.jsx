import React, { useState } from 'react';
import PropTypes from 'prop-types';

const EditableInput = ({ exampleValue, iconOnNextLine }) => {
  const [value, setValue] = useState('');
  const [editing, setEditing] = useState(false);

  const editInput = () => {
    setEditing(true);
  };

  const handleChange = (event) => {
    setValue(event.target.value);
  };

  const leaveInput = () => {
    setEditing(false);
  };

  let valueElement;
  if (editing) {
    valueElement = (
      <input
        type="text"
        className="bg-light border-0 mw-100 text-center py-0 no-outline"
        value={value}
        onChange={handleChange}
        onBlur={leaveInput}
        // eslint-disable-next-line jsx-a11y/no-autofocus
        autoFocus
      />
    );
  } else {
    valueElement = value;
  }

  return (
    <div>
      {(value || editing) ? (
        valueElement
      ) : (
        <span className="fst-italic text-black-50">{exampleValue}</span>
      )}

      {iconOnNextLine && <br />}

      <span role="button" onClick={editInput} tabIndex="0" onKeyDown={editInput}>
        <i className={`bi bi-pencil-square fa-xs ${iconOnNextLine ? '' : 'ms-2'}`} />
      </span>
    </div>
  );
};

EditableInput.propTypes = {
  exampleValue: PropTypes.string,
  iconOnNextLine: PropTypes.bool
};

EditableInput.defaultProps = {
  exampleValue: '',
  iconOnNextLine: true
};

export default EditableInput;
