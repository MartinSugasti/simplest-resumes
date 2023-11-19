import React from 'react';
import PropTypes from 'prop-types';

import SpecificReferences from './SpecificReferences';
import { examplePersonalReferences, exampleJobReferences } from '../constants';

const References = ({ resumeId }) => (
  <div className="card-body row py-0">
    <SpecificReferences title="personal" resumeId={resumeId} exampleReferences={examplePersonalReferences} />
    <SpecificReferences title="job" resumeId={resumeId} exampleReferences={exampleJobReferences} />
  </div>
);

References.propTypes = {
  resumeId: PropTypes.number
};

References.defaultProps = {
  resumeId: null
};

export default References;
