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
      <EditableInput inputName="name" exampleValue={exampleName} iconOnNextLine={false} />
    </h1>

    <div className="row mt-2">
      <span className="col-12 col-md-4 card-text">
        <i className="bi bi-envelope-at" />
        <br />
        <EditableInput inputName="email" exampleValue={exampleEmail} />
      </span>

      <span className="col-12 col-md-4 card-text mt-2 mt-md-0">
        <i className="bi bi-phone" />
        <br />
        <EditableInput inputName="mobile" exampleValue={exampleMobile} />
      </span>

      <span className="col-12 col-md-4 card-tex mt-2 mt-md-0">
        <i className="bi bi-geo-alt" />
        <br />
        <EditableInput inputName="location" exampleValue={exampleLocation} />
      </span>
    </div>
  </div>
);

export default PersonalInformation;
