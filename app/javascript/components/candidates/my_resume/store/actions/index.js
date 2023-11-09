export const UPDATE_TEXT_INPUT = 'UPDATE_TEXT_INPUT';
export const ADD_ITEM = 'ADD_ITEM';
export const REMOVE_ITEM = 'REMOVE_ITEM';

export const updateTextInput = (inputName, text) => ({
  type: UPDATE_TEXT_INPUT,
  inputName,
  text
});

export const addItem = (listName, item) => ({
  type: ADD_ITEM,
  listName,
  item
});

export const removeItem = (listName, index) => ({
  type: REMOVE_ITEM,
  listName,
  index
});
