import React from 'react';
import PropTypes from 'prop-types';

import LinkWithLoaderAndScrolling from '../../shared/LinkWithLoaderAndScrolling';

const CarouselCard = ({
  active,
  image,
  children,
  insuranceType
}) => (
  <div className={`carousel-item ${active ? 'active' : ''} card border-0 bg-transparent text-light h-100`}>
    <div className="row mx-0 g-0 h-100">
      <div className="col-md-6 align-self-center text-center">
        <img src={image} className="img-fluid rounded-start" alt="..." />
      </div>
      <div className="col-md-6 align-self-md-center text-center">
        <div className="card-body d-inline-block text-start">
          {children}
          <div className="text-center">
            <LinkWithLoaderAndScrolling
              to={insuranceType ? `/cotizacion?insurance_type=${insuranceType}` : '/cotizacion'}
              sectionId="cotizacion-intro"
              className="btn btn-outline-light rounded-pill w-50 mt-3"
            >
              Cotizar
            </LinkWithLoaderAndScrolling>
          </div>
        </div>
      </div>
    </div>
  </div>
);

CarouselCard.propTypes = {
  active: PropTypes.bool,
  image: PropTypes.node.isRequired,
  children: PropTypes.node.isRequired,
  insuranceType: PropTypes.string
};

CarouselCard.defaultProps = {
  active: false,
  insuranceType: null
};

export default CarouselCard;
