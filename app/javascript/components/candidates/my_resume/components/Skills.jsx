import React, { useState } from 'react';

import SkillModal from './SkillModal';
import { examplePrimarySkills, exampleSecondarySkills } from '../constants';

const Skills = () => {
  const [primarySkills, setPrimarySkills] = useState([]);
  const [secondarySkills, setSecondarySkills] = useState([]);

  const addSkill = (name, kind) => {
    if (kind === 'primary') {
      setPrimarySkills([...primarySkills, name]);
    } else {
      setSecondarySkills([...secondarySkills, name]);
    }
  };

  const removePrimarySkill = (indexToRemove) => {
    setPrimarySkills(primarySkills.filter((_, index) => index !== indexToRemove));
  };

  const removeSecondarySkill = (indexToRemove) => {
    setSecondarySkills(secondarySkills.filter((_, index) => index !== indexToRemove));
  };

  return (
    <div className="card-body py-0">
      <h3 className="mt-3 mb-0 text-md-start">
        Skills

        <span role="button">
          <i
            className="bi bi-plus-circle fa-xs ms-2"
            data-bs-toggle="modal"
            data-bs-target="#newSkillModal"
          />
        </span>
      </h3>

      <div className="d-md-flex text-md-start mt-2">
        {primarySkills.length > 0 ? (
          primarySkills.map((item, index) => (
            <p key={item} id={index} className="mb-0 fw-bold">
              {item}
              <span
                role="button"
                onClick={() => removePrimarySkill(index)}
                tabIndex="0"
                onKeyDown={() => removePrimarySkill(index)}
              >
                <i className="bi bi-trash fa-sm ms-2" />
              </span>
              {primarySkills.length !== index + 1 && (
                <span className="d-none d-md-inline mx-1">-</span>
              )}
            </p>
          ))
        ) : (
          examplePrimarySkills.map((item, index) => (
            <p key={item} id={index} className="mb-0 fw-bold fst-italic text-black-50">
              {item}
              {examplePrimarySkills.length !== index + 1 && (
                <span className="d-none d-md-inline mx-1">-</span>
              )}
            </p>
          ))
        )}
      </div>

      <div className="d-md-flex text-md-start mt-2">
        {secondarySkills.length > 0 ? (
          secondarySkills.map((item, index) => (
            <p key={item} id={index} className="mb-0">
              {item}
              <span
                role="button"
                onClick={() => removeSecondarySkill(index)}
                tabIndex="0"
                onKeyDown={() => removeSecondarySkill(index)}
              >
                <i className="bi bi-trash fa-sm ms-2" />
              </span>
              {secondarySkills.length !== index + 1 && (
                <span className="d-none d-md-inline mx-1">-</span>
              )}
            </p>
          ))
        ) : (
          exampleSecondarySkills.map((item, index) => (
            <p key={item} id={index} className="mb-0 fst-italic text-black-50">
              {item}
              {exampleSecondarySkills.length !== index + 1 && (
                <span className="d-none d-md-inline mx-1">-</span>
              )}
            </p>
          ))
        )}
      </div>

      <SkillModal addSkill={addSkill} />
    </div>
  );
};

export default Skills;
