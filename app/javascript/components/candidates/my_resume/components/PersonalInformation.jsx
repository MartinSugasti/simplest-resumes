import React from 'react';

import EditableInput from './EditableInput';
import {
  exampleName,
  exampleEmail,
  exampleMobile,
  exampleLocation
} from '../constants';

const PersonalInformation = () => (
  <div className="card-body text-center py-0">
    <h1 className="mb-0">
      <EditableInput exampleValue={exampleName} iconOnNextLine={false} />
    </h1>

    <div className="row mt-2">
      <span className="col-12 col-md-4 card-text">
        <i className="bi bi-envelope-at" />
        <br />
        <EditableInput exampleValue={exampleEmail} />
      </span>

      <span className="col-12 col-md-4 card-text mt-2 mt-md-0">
        <i className="bi bi-phone" />
        <br />
        <EditableInput exampleValue={exampleMobile} />
      </span>

      <span className="col-12 col-md-4 card-tex mt-2 mt-md-0">
        <i className="bi bi-geo-alt" />
        <br />
        <EditableInput exampleValue={exampleLocation} />
      </span>
    </div>
  </div>
);

export default PersonalInformation;
