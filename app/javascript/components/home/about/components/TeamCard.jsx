import React from 'react';
import PropTypes from 'prop-types';

const TeamCard = ({
  name,
  position,
  email,
  linkedinUrl,
  image
}) => (
  <div className="card border-0 rounded-4 text-center shadow-lg h-100 bg-light">
    <div className="card-body p-0 hover hover-2 rounded-4">
      <img src={image} className="img-fluid rounded-4" alt="member" />

      <div className="hover-overlay" />

      <div className="hover-2-content">
        <div className="hover-2-description">
          <h5 className="text-light mb-0 mb-sm-1">{name}</h5>
          <h5 className="text-secondary-light mb-0 mb-sm-1">{position}</h5>
          <a
            href={`mailto:${email}`}
            className="email-link text-light me-3"
            target="_blank"
            rel="noreferrer"
          >
            <i className="text-light bi bi-envelope-fill" />
          </a>
          {linkedinUrl && (
            <a href={linkedinUrl} alt="link-to-linkedin" target="_blank" rel="noreferrer" className="linkedin-link">
              <i className="text-light bi bi-linkedin" />
            </a>
          )}
        </div>
      </div>
    </div>
  </div>
);

TeamCard.propTypes = {
  name: PropTypes.string.isRequired,
  position: PropTypes.string.isRequired,
  email: PropTypes.string.isRequired,
  linkedinUrl: PropTypes.string,
  image: PropTypes.node.isRequired
};

TeamCard.defaultProps = {
  linkedinUrl: null
};

export default TeamCard;
