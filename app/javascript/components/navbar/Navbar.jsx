import React from 'react';
import PropTypes from 'prop-types';
import i18n from '../shared/i18n';

const Navbar = ({ user }) => (
  <div className="navbar navbar-expand">
    <button
      className="btn border-0 d-lg-none"
      type="button"
      data-bs-toggle="offcanvas"
      data-bs-target="#sidebar-mobile"
      aria-controls="sidebar-mobile"
      data-bs-theme="dark"
    >
      <span className="navbar-toggler-icon" />
    </button>

    <form id="search-form" className="d-flex m-auto pe-2" role="search">
      <input
        className="form-control me-2 bg-light"
        type="search"
        placeholder={i18n.t('dashboard.search')}
        aria-label="Search"
      />
      <button className="btn btn-outline-light" type="submit">
        {i18n.t('dashboard.search')}
      </button>
    </form>
  </div>
);

Navbar.propTypes = {
  user: PropTypes.shape({})
};

Navbar.defaultProps = {
  user: {}
};

export default Navbar;
