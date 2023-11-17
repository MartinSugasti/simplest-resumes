import { updateResume } from '../../api';

export const REQUEST_SENDING = 'REQUEST_SENDING';
export const REQUEST_SUCCESS = 'REQUEST_SUCCESS';
export const REQUEST_FAILURE = 'REQUEST_FAILURE';
export const SET_TEXT_INPUT = 'SET_TEXT_INPUT';
export const ADD_ITEM = 'ADD_ITEM';
export const REMOVE_ITEM = 'REMOVE_ITEM';

const camelToSnakeCase = (str) => str.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`);

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
    dispatch(addItem('primarySkillsItems', item));
  });
  resume.secondary_skill_items.forEach((item) => {
    dispatch(addItem('secondarySkillsItems', item));
  });
  resume.personal_reference_items.forEach((item) => {
    dispatch(addItem('personalReferencesItems', item));
  });
  resume.job_reference_items.forEach((item) => {
    dispatch(addItem('jobReferencesItems', item));
  });

  dispatch(requestSuccess());
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
