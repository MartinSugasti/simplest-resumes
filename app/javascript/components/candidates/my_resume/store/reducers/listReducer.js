import {
  ADD_ITEM,
  REMOVE_ITEM
} from '../actions';

// eslint-disable-next-line default-param-last
const listReducer = (listName, initialValue = []) => (state = { items: initialValue }, action) => {
  if (action.listName !== listName) {
    return state;
  }

  switch (action.type) {
    case ADD_ITEM:
      return {
        ...state,
        items: [...state.items, action.item]
      };
    case REMOVE_ITEM:
      return {
        ...state,
        items: state.items.filter((item) => item.id !== action.id)
      };
    default:
      return state;
  }
};

export default listReducer;
