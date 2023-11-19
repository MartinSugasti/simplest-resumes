import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';

import { connect } from 'react-redux';
import { populateInitialValues } from './store/actions';

import Loader from '../../shared/Loader';
import Toaster, { showErrorToast } from '../../shared/Toaster';
import AboutMe from './components/AboutMe';
import PersonalInformation from './components/PersonalInformation';
import Education from './components/Education';
import WorkExperience from './components/WorkExperience';
import Skills from './components/Skills';
import References from './components/References';
import { getResume } from './api';

const MyResume = ({ requestStatus, errorMessage, populateValues }) => {
  const [resumeId, setResumeId] = useState();

  useEffect(() => {
    getResume()
      .then((response) => {
        setResumeId(response.data.id);
        populateValues(response.data);
      })
      .catch(() => showErrorToast('Something went wrong. Please, try again later!'));
  }, [populateValues]);

  useEffect(() => {
    if (requestStatus === 'failure') {
      showErrorToast(errorMessage || 'Something went wrong. Please, try again later!');
    }
  }, [requestStatus, errorMessage]);

  return (
    <>
      <div className="mb-3">
        <button type="button" className="btn btn-outline-primary">Download</button>
      </div>

      {requestStatus === 'sending' ? (
        <div className="align-items-center d-flex justify-content-center my-5 py-5"><Loader /></div>
      ) : (
        <div className="card py-3 border-2 text-dark">
          <PersonalInformation />
          <AboutMe />
          <Education resumeId={resumeId} />
          <WorkExperience resumeId={resumeId} />
          <Skills resumeId={resumeId} />
          <References resumeId={resumeId} />
        </div>
      )}

      <Toaster />
    </>
  );
};

const mapStateToProps = (state) => ({
  requestStatus: state.requestStatus.status,
  errorMessage: state.requestStatus.errorMessage
});

const mapDispatchToProps = (dispatch) => ({
  populateValues: (resume) => {
    dispatch(populateInitialValues(resume));
  }
});

MyResume.propTypes = {
  populateValues: PropTypes.func.isRequired,
  requestStatus: PropTypes.string.isRequired,
  errorMessage: PropTypes.string
};

MyResume.defaultProps = {
  errorMessage: null
};

export default connect(mapStateToProps, mapDispatchToProps)(MyResume);
