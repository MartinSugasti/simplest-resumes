import React from 'react';

import calculatorImage from '../../../../images/others/calculator.png';

const Intro = () => (
  <section id="cotizador-intro" className="bg-light">
    <div className="container-lg py-5">
      <div className="row mx-0 g-4 justify-content-around align-items-center">
        <div className="col-md-6 order-md-2 text-center mt-4 mt-md-0">
          <h1 className="text-dark mb-0">Cotizador de Seguros</h1>
          <p className="text-muted mb-2 fst-italic">Envianos tu información y te responderemos a la brevedad</p>
        </div>
        <div className="col-10 col-sm-8 col-md-6 order-md-1 text-center">
          <img src={calculatorImage} className="img-fluid" alt="calculator" />
        </div>
      </div>
    </div>
  </section>
);

export default Intro;
