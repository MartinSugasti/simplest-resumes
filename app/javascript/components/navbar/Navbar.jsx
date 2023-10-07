import React from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

const Navbar = ({ user }) => {
  const { t } = useTranslation();

  return (
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
          placeholder={t('dashboard.search')}
          aria-label="Search"
        />
        <button className="btn btn-outline-light" type="submit">
          {t('dashboard.search')}
        </button>
      </form>
    </div>
  );
};

Navbar.propTypes = {
  user: PropTypes.shape({})
};

Navbar.defaultProps = {
  user: {}
};

export default Navbar;
