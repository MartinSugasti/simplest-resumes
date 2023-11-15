import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';

import { connect } from 'react-redux';
import { updateTextInput, addItem } from './store/actions';

import Loader from '../../shared/Loader';
import AboutMe from './components/AboutMe';
import PersonalInformation from './components/PersonalInformation';
import Education from './components/Education';
import WorkExperience from './components/WorkExperience';
import Skills from './components/Skills';
import References from './components/References';
import { getResume } from './api';

const MyResume = ({
  onLoad
}) => {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    getResume().then((response) => {
      console.log(response.data);
      onLoad(response.data);
      setLoading(false);
    });
  }, [onLoad]);

  return (
    <>
      <div className="mb-3">
        <button type="button" className="btn btn-outline-primary">Download</button>
      </div>

      {loading ? (
        <div className="align-items-center d-flex justify-content-center my-5 py-5"><Loader /></div>
      ) : (
        <div className="card py-3 border-2 text-dark">
          <PersonalInformation />
          <AboutMe />
          <Education />
          <WorkExperience />
          <Skills />
          <References />
        </div>
      )}
    </>
  );
};

const mapDispatchToProps = (dispatch) => ({
  onLoad: (resume) => {
    if (!resume) { return; }

    dispatch(updateTextInput('name', resume.name));
    dispatch(updateTextInput('email', resume.email));
    dispatch(updateTextInput('mobile', resume.mobile));
    dispatch(updateTextInput('location', resume.location));
    dispatch(updateTextInput('aboutMe', resume.about_me));

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
  }
});

MyResume.propTypes = {
  onLoad: PropTypes.func.isRequired
};

MyResume.defaultProps = {

};

export default connect(null, mapDispatchToProps)(MyResume);
