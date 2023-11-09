import React, { useState } from 'react';
import PropTypes from 'prop-types';

import { connect } from 'react-redux';
import { updateTextInput } from '../store/actions';

const EditableInput = ({
  inputName,
  exampleValue,
  iconOnNextLine,
  text,
  onInputChange
}) => {
  const [editing, setEditing] = useState(false);

  const editInput = () => {
    setEditing(true);
  };

  const leaveInput = (event) => {
    onInputChange(inputName, event.target.value);
    setEditing(false);
  };

  let valueElement;
  if (editing) {
    valueElement = (
      <input
        type="text"
        className="bg-light border-0 mw-100 text-center py-0 no-outline"
        defaultValue={text}
        onBlur={leaveInput}
        // eslint-disable-next-line jsx-a11y/no-autofocus
        autoFocus
      />
    );
  } else {
    valueElement = text;
  }

  return (
    <div>
      {(text || editing) ? (
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

const mapStateToProps = (state, ownProps) => ({
  text: state[ownProps.inputName].text
});

const mapDispatchToProps = (dispatch) => ({
  onInputChange: (inputName, text) => {
    dispatch(updateTextInput(inputName, text));
  }
});

EditableInput.propTypes = {
  inputName: PropTypes.string.isRequired,
  exampleValue: PropTypes.string,
  iconOnNextLine: PropTypes.bool,
  text: PropTypes.string,
  onInputChange: PropTypes.func.isRequired
};

EditableInput.defaultProps = {
  exampleValue: '',
  iconOnNextLine: true,
  text: null
};

export default connect(mapStateToProps, mapDispatchToProps)(EditableInput);
