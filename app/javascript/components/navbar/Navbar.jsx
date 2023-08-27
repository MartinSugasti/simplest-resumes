import React from 'react';
import PropTypes from 'prop-types';

const Navbar = ({ user }) => (
  <>
    <button id="sidebar-toggler" className="btn border-0" type="button" data-bs-theme="dark">
      <span className="navbar-toggler-icon" />
    </button>

    <form id="search-form" className="d-flex m-auto pe-2" role="search">
      <input className="form-control me-2 bg-light" type="search" placeholder="Search" aria-label="Search" />
      <button className="btn btn-outline-light" type="submit">Search</button>
    </form>
  </>
);

Navbar.propTypes = {
  user: PropTypes.shape({})
};

Navbar.defaultProps = {
  user: {}
};

export default Navbar;
