import React from 'react';

import LinkWithLoaderAndScrolling from '../../shared/LinkWithLoaderAndScrolling';

import resumesImage from '../../../../images/others/resumes.png';

const Intro = () => (
  <section id="main-intro" className="bg-light">
    <div className="container-lg py-5">
      <div className="row mx-0 g-4 align-items-center justify-content-around">
        <div className="col-md-6 text-center">
          <h1 className="text-dark mb-0">Simplest Resume You Can Get!</h1>
          <p className="text-muted mb-2 fst-italic">Keep resumes simple</p>

          <LinkWithLoaderAndScrolling
            to="/home#contact"
            sectionId="contact"
            className="btn btn-outline-primary-dark rounded-pill"
          >
            Contact Us
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
