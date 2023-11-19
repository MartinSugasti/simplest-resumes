import { updateResume, postItem, deleteItem } from '../../api';

export const REQUEST_SENDING = 'REQUEST_SENDING';
export const REQUEST_SUCCESS = 'REQUEST_SUCCESS';
export const REQUEST_FAILURE = 'REQUEST_FAILURE';
export const SET_TEXT_INPUT = 'SET_TEXT_INPUT';
export const ADD_ITEM = 'ADD_ITEM';
export const REMOVE_ITEM = 'REMOVE_ITEM';

const camelToSnakeCase = (str) => str.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`);
const cleanItemType = (itemType) => (
  itemType.replace('primary_', '').replace('secondary_', '').replace('personal_', '').replace('job_', '')
);

export const sendRequest = () => ({
  type: REQUEST_SENDING
});

export const requestSuccess = () => ({
  type: REQUEST_SUCCESS
});

export const requestFailure = (errorMessage) => ({
  type: REQUEST_FAILURE,
  errorMessage
});

export const setTextInput = (inputName, text) => ({
  type: SET_TEXT_INPUT,
  inputName,
  text
});

export const updateTextInput = (inputName, text) => ((dispatch) => {
  dispatch(sendRequest());

  const params = {};
  params[camelToSnakeCase(inputName)] = text;

  updateResume(params)
    .then(() => {
      dispatch(requestSuccess());
      dispatch(setTextInput(inputName, text));
    })
    .catch((error) => {
      dispatch(requestFailure(error.response.data.errors));
    });
});

export const addItem = (listName, item) => ({
  type: ADD_ITEM,
  listName,
  item
});

export const removeItem = (listName, id) => ({
  type: REMOVE_ITEM,
  listName,
  id
});

export const createItem = (itemType, item) => ((dispatch) => {
  dispatch(sendRequest());

  const itemTypeSnakeName = cleanItemType(camelToSnakeCase(itemType));
  const params = {};
  params[itemTypeSnakeName] = item;

  postItem(itemTypeSnakeName, params)
    .then((response) => {
      dispatch(requestSuccess());

      // prepending an 's' always works as lists ends in '..Items'
      dispatch(addItem(`${itemType}s`, { id: response.data.id, ...item }));
    })
    .catch((error) => {
      dispatch(requestFailure(error.response.data.errors));
    });
});

export const destroyItem = (itemType, id) => ((dispatch) => {
  dispatch(sendRequest());

  const itemTypeSnakeName = cleanItemType(camelToSnakeCase(itemType));

  deleteItem(itemTypeSnakeName, id)
    .then(() => {
      dispatch(requestSuccess());
      dispatch(removeItem(`${itemType}s`, id)); // prepending an 's' always works as lists ends in '..Items'
    })
    .catch((error) => {
      dispatch(requestFailure(error.response.data.errors));
    });
});

export const populateInitialValues = (resume) => ((dispatch) => {
  dispatch(setTextInput('name', resume.name));
  dispatch(setTextInput('email', resume.email));
  dispatch(setTextInput('mobile', resume.mobile));
  dispatch(setTextInput('location', resume.location));
  dispatch(setTextInput('aboutMe', resume.about_me));

  resume.education_items.forEach((item) => {
    dispatch(addItem('educationItems', item));
  });
  resume.work_experience_items.forEach((item) => {
    dispatch(addItem('workExperienceItems', item));
  });
  resume.primary_skill_items.forEach((item) => {
    dispatch(addItem('primarySkillItems', item));
  });
  resume.secondary_skill_items.forEach((item) => {
    dispatch(addItem('secondarySkillItems', item));
  });
  resume.personal_reference_items.forEach((item) => {
    dispatch(addItem('personalReferenceItems', item));
  });
  resume.job_reference_items.forEach((item) => {
    dispatch(addItem('jobReferenceItems', item));
  });

  dispatch(requestSuccess());
});
