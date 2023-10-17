import React from 'react';

import AboutMe from './components/AboutMe';
import PersonalInformation from './components/PersonalInformation';
import Education from './components/Education';
import WorkExperience from './components/WorkExperience';
import Skills from './components/Skills';
import References from './components/References';

const MyResume = () => (
  <div id="my-resume" className="card py-3 border-2 text-dark">
    <PersonalInformation />
    <AboutMe />
    <Education />
    <WorkExperience />
    <Skills />
    <References />
  </div>
);

export default MyResume;
