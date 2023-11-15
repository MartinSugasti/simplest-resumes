import React, { useState } from 'react';
import PropTypes from 'prop-types';

import { connect } from 'react-redux';
import { updateTextInput } from '../store/actions';

import { exampleAboutMe } from '../constants';

const AboutMe = ({ text, onInputChange }) => {
  const [editing, setEditing] = useState(false);

  const editInput = () => {
    setEditing(true);
  };

  const inputFocusOut = (event) => {
    onInputChange(event.target.value);
    setEditing(false);
  };

  let valueElement;
  if (editing) {
    valueElement = (
      <textarea
        className="bg-light border-0 w-100 py-0 no-outline"
        rows="5"
        defaultValue={text}
        onBlur={inputFocusOut}
        // eslint-disable-next-line jsx-a11y/no-autofocus
        autoFocus
      />
    );
  } else {
    valueElement = text;
  }

  return (
    <div className="card-body py-0">
      <h3 className="mt-3 mb-0 text-md-start">
        About Me

        <span role="button" onClick={editInput} tabIndex="0" onKeyDown={editInput}>
          <i className="bi bi-pencil-square fa-xs ms-2" />
        </span>
      </h3>

      {(text || editing) ? (
        <p className="mt-2 mb-0 text-md-start">{valueElement}</p>
      ) : (
        <p className="mt-2 mb-0 text-md-start fst-italic text-black-50">{exampleAboutMe}</p>
      )}
    </div>
  );
};

const mapStateToProps = (state) => ({
  text: state.aboutMe.text
});

const mapDispatchToProps = (dispatch) => ({
  onInputChange: (text) => {
    dispatch(updateTextInput('aboutMe', text));
  }
});

AboutMe.propTypes = {
  text: PropTypes.string,
  onInputChange: PropTypes.func.isRequired
};

AboutMe.defaultProps = {
  text: null
};

export default connect(mapStateToProps, mapDispatchToProps)(AboutMe);
