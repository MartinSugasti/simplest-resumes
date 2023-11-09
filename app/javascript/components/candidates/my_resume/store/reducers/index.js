import { combineReducers } from 'redux';
import textInputReducer from './textInputReducer';
import listReducer from './listReducer';

export default combineReducers({
  name: textInputReducer('name'),
  email: textInputReducer('email'),
  mobile: textInputReducer('mobile'),
  location: textInputReducer('location'),
  aboutMe: textInputReducer('aboutMe'),
  educationItems: listReducer('educationItems'),
  workExperienceItems: listReducer('workExperienceItems'),
  primarySkillsItems: listReducer('primarySkillsItems'),
  secondarySkillsItems: listReducer('secondarySkillsItems'),
  personalReferencesItems: listReducer('personalReferencesItems'),
  jobReferencesItems: listReducer('jobReferencesItems')
});
