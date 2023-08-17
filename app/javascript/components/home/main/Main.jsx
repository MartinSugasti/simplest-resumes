import React from 'react';

import Intro from './components/Intro';
import Seguros from './components/Seguros';
import Servicios from './components/Servicios';
import Companias from './components/Companias';
import Contacto from './components/Contacto';
import Reviews from './components/Reviews';

const Main = () => (
  <>
    <Intro />
    <Seguros />
    <Companias />
    <Servicios />
    <Reviews />
    <Contacto />
  </>
);

export default Main;
