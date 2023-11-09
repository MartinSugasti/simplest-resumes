import React from 'react';
import PropTypes from 'prop-types';

import { connect } from 'react-redux';
import AboutMe from './components/AboutMe';
import PersonalInformation from './components/PersonalInformation';
import Education from './components/Education';
import WorkExperience from './components/WorkExperience';
import Skills from './components/Skills';
import References from './components/References';

const MyResume = ({
  name,
  email,
  mobile,
  location,
  aboutMe,
  educationItems,
  workExperienceItems,
  primarySkillsItems,
  secondarySkillsItems,
  personalReferencesItems,
  jobReferencesItems
}) => (
  <>
    { console.log('name: ' + name) }
    { console.log('email: ' + email) }
    { console.log('mobile: ' + mobile) }
    { console.log('location: ' + location) }
    { console.log('aboutMe: ' + aboutMe) }
    { console.log('educationItems: ' + JSON.stringify(educationItems)) }
    { console.log('workExperienceItems: ' + JSON.stringify(workExperienceItems)) }
    { console.log('primarySkillsItems: ' + JSON.stringify(primarySkillsItems)) }
    { console.log('secondarySkillsItems: ' + JSON.stringify(secondarySkillsItems)) }
    { console.log('personalReferencesItems: ' + JSON.stringify(personalReferencesItems)) }
    { console.log('jobReferencesItems: ' + JSON.stringify(jobReferencesItems)) }

    <div className="mb-3">
      <button type="button" className="btn btn-primary text-light me-2">Save</button>
      <button type="button" className="btn btn-outline-primary">Download</button>
    </div>

    <div className="card py-3 border-2 text-dark">
      <PersonalInformation />
      <AboutMe />
      <Education />
      <WorkExperience />
      <Skills />
      <References />
    </div>
  </>
);

const mapStateToProps = (state) => ({
  name: state.name.text,
  email: state.email.text,
  mobile: state.mobile.text,
  location: state.location.text,
  aboutMe: state.aboutMe.text,
  educationItems: state.educationItems.items,
  workExperienceItems: state.workExperienceItems.items,
  primarySkillsItems: state.primarySkillsItems.items,
  secondarySkillsItems: state.secondarySkillsItems.items,
  personalReferencesItems: state.personalReferencesItems.items,
  jobReferencesItems: state.jobReferencesItems.items
});

MyResume.propTypes = {
  name: PropTypes.string.isRequired,
  email: PropTypes.string.isRequired,
  mobile: PropTypes.string.isRequired,
  location: PropTypes.string.isRequired,
  aboutMe: PropTypes.string.isRequired,
  educationItems: PropTypes.arrayOf(
    PropTypes.shape({})
  ).isRequired,
  workExperienceItems: PropTypes.arrayOf(
    PropTypes.shape({})
  ).isRequired,
  primarySkillsItems: PropTypes.arrayOf(
    PropTypes.string
  ).isRequired,
  secondarySkillsItems: PropTypes.arrayOf(
    PropTypes.string
  ).isRequired,
  personalReferencesItems: PropTypes.arrayOf(
    PropTypes.shape({})
  ).isRequired,
  jobReferencesItems: PropTypes.arrayOf(
    PropTypes.shape({})
  ).isRequired
};

MyResume.defaultProps = {

};

export default connect(mapStateToProps)(MyResume);
