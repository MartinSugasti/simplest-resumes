import { combineReducers } from 'redux';
import textInputReducer from './textInputReducer';
import listReducer from './listReducer';
import requestStatusReducer from './requestStatusReducer';

export default combineReducers({
  name: textInputReducer('name'),
  email: textInputReducer('email'),
  mobile: textInputReducer('mobile'),
  location: textInputReducer('location'),
  aboutMe: textInputReducer('aboutMe'),
  educationItems: listReducer('educationItems'),
  workExperienceItems: listReducer('workExperienceItems'),
  primarySkillItems: listReducer('primarySkillItems'),
  secondarySkillItems: listReducer('secondarySkillItems'),
  personalReferenceItems: listReducer('personalReferenceItems'),
  jobReferenceItems: listReducer('jobReferenceItems'),
  externalLinkItems: listReducer('externalLinkItems'),
  requestStatus: requestStatusReducer
});
