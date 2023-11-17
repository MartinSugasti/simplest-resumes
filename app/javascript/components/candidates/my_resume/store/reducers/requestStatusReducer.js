import {
  REQUEST_SENDING,
  REQUEST_SUCCESS,
  REQUEST_FAILURE
} from '../actions';

// eslint-disable-next-line default-param-last
const requestStatusReducer = (state = { status: 'sending', errorMessage: null }, action) => {
  switch (action.type) {
    case REQUEST_SENDING:
      return { status: 'sending', errorMessage: null };
    case REQUEST_SUCCESS:
      return { status: 'success', errorMessage: null };
    case REQUEST_FAILURE:
      return { status: 'failure', errorMessage: action.errorMessage };
    default:
      return state;
  }
};

export default requestStatusReducer;
