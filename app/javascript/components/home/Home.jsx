import React from 'react';
import PropTypes from 'prop-types';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

import Navbar from './shared/Navbar';
import Main from './main/Main';
import About from './about/About';
import Cotizacion from './cotizacion/Cotizacion';
import Footer from './shared/Footer';
import WhatsappIcon from './shared/WhatsappIcon';

const Home = ({ userSignedIn }) => (
  <Router>
    <Navbar userSignedIn={userSignedIn} />

    <Routes>
      <Route exact path="/about" element={<About />} />
      <Route exact path="/cotizacion" element={<Cotizacion />} />
      <Route path="/*" element={<Main />} />
    </Routes>

    <Footer />
    <WhatsappIcon />
  </Router>
);

Home.propTypes = {
  userSignedIn: PropTypes.bool
};

Home.defaultProps = {
  userSignedIn: false
};

export default Home;
