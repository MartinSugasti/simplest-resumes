import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

import Navbar from './shared/Navbar';
import Main from './main/Main';
import About from './about/About';
import Cotizacion from './cotizacion/Cotizacion';
import Footer from './shared/Footer';
import WhatsappIcon from './shared/WhatsappIcon';

const Home = () => (
  <Router>
    <Navbar />

    <Routes>
      <Route exact path="/" element={<Main />} />
      <Route exact path="/about" element={<About />} />
      <Route exact path="/cotizacion" element={<Cotizacion />} />
    </Routes>

    <Footer />
    <WhatsappIcon />
  </Router>
);

export default Home;
