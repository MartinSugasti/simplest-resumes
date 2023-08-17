import React from 'react';
import PropTypes from 'prop-types';

const ButtonAsLinkToSection = ({
  className,
  sectionId,
  path,
  children
}) => {
  const scrollToSection = () => {
    const section = document.getElementById(sectionId);

    if (section) {
      if (sectionId === 'intro') {
        document.getElementById('root').scrollIntoView();
      } else {
        section.scrollIntoView();
      }
    } else {
      window.location.href = path;
    }
  };

  return (
    <button
      type="button"
      className={className}
      onClick={scrollToSection}
    >
      {children}
    </button>
  );
};

ButtonAsLinkToSection.propTypes = {
  sectionId: PropTypes.string.isRequired,
  className: PropTypes.string,
  path: PropTypes.string.isRequired,
  children: PropTypes.node.isRequired
};

ButtonAsLinkToSection.defaultProps = {
  className: null
};

export default ButtonAsLinkToSection;
