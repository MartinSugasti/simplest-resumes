import { SET_TEXT_INPUT } from '../actions';

// eslint-disable-next-line default-param-last
const textInputReducer = (inputName, initialValue = '') => (state = { text: initialValue }, action) => {
  if (action.inputName !== inputName) {
    return state;
  }

  switch (action.type) {
    case SET_TEXT_INPUT:
      return {
        ...state,
        text: action.text
      };
    default:
      return state;
  }
};

export default textInputReducer;
