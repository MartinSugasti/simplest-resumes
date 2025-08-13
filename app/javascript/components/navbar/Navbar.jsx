import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

const Navbar = ({ userType }) => {
  const { t } = useTranslation();
  const [searchQuery, setSearchQuery] = useState('');

  const handleSearchSubmit = (e) => {
    e.preventDefault();

    // TODO: Implement search for admins
    if (searchQuery.trim() && userType !== 'admin') {
      let path = '';

      if (userType === 'recruiter') {
        path = '/recruiters/candidates';
      } else if (userType === 'candidate') {
        path = '/candidates/job_postings';
      }

      // We have to use window.location.href because the navbar is a separate
      // React component and we can't use the router to navigate to other pages
      // TODO: After we move the whole dashboard to a React component,
      // TODO: we can use the router to navigate to other pages
      window.location.href = `${path}?query=${encodeURIComponent(searchQuery.trim())}`;
    }
  };

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

      <form id="search-form" className="d-flex m-auto pe-2" role="search" onSubmit={handleSearchSubmit}>
        <input
          className="form-control me-2 bg-light"
          type="search"
          placeholder={t(`dashboard.${userType}s.search`)}
          aria-label="Search"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
        <button className="btn btn-outline-light" type="submit">
          {t('dashboard.search')}
        </button>
      </form>
    </div>
  );
};

Navbar.propTypes = {
  userType: PropTypes.string.isRequired
};

export default Navbar;
