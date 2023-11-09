import React from 'react';

import SpecificReferences from './SpecificReferences';
import { examplePersonalReferences, exampleJobReferences } from '../constants';

const References = () => (
  <div className="card-body row py-0">
    <SpecificReferences title="personal" exampleReferences={examplePersonalReferences} />
    <SpecificReferences title="job" exampleReferences={exampleJobReferences} />
  </div>
);

export default References;
