import React from 'react';

import LinkWithLoaderAndScrolling from '../../shared/LinkWithLoaderAndScrolling';

import resumesImage from '../../../../images/others/resumes.png';

const Intro = () => (
  <section id="main-intro" className="bg-light">
    <div className="container-lg py-5">
      <div className="row mx-0 g-4 align-items-center justify-content-around">
        <div className="col-md-6 text-center">
          <h1 className="text-dark mb-0">Especialistas en Seguros</h1>
          <p className="text-muted mb-2 fst-italic">Lideres en Servicios desde 1987</p>

          <LinkWithLoaderAndScrolling
            to="/home#contacto"
            sectionId="contacto"
            className="btn btn-outline-primary-dark rounded-pill"
          >
            Contáctenos
          </LinkWithLoaderAndScrolling>
        </div>

        <div className="col-12 col-sm-8 col-md-6 text-center">
          <img src={resumesImage} className="img-fluid" alt="family" />
        </div>
      </div>
    </div>
  </section>
);

export default Intro;
