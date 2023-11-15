import React from 'react';
import PropTypes from 'prop-types';

import { RotatingLines } from 'react-loader-spinner';

const Loader = ({ strokeColor, width }) => (
  <RotatingLines
    strokeColor={strokeColor}
    strokeWidth="3"
    animationDuration="0.75"
    width={width}
    visible
  />
);

Loader.propTypes = {
  strokeColor: PropTypes.string,
  width: PropTypes.string
};

Loader.defaultProps = {
  strokeColor: '#5883C8',
  width: '96'
};

export default Loader;
