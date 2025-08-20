import React from 'react';
import { useTranslation } from 'react-i18next';

import LinkWithLoaderAndScrolling from '../../shared/LinkWithLoaderAndScrolling';

import resumesImage from '../../../../images/others/resumes.svg';

const Intro = () => {
  const { t } = useTranslation();

  return (
    <section id="main-intro" className="bg-light">
      <div className="container-lg py-5">
        <div className="row mx-0 g-4 align-items-center justify-content-around">
          <div className="col-md-6 text-center">
            <h1 className="text-dark mb-0">{t('pages.home.intro.title')}</h1>
            <p className="text-muted mb-2 fst-italic">{t('pages.home.intro.subtitle')}</p>

            <LinkWithLoaderAndScrolling
              to="/home#contact"
              sectionId="contact"
              className="btn btn-outline-primary-dark rounded-pill"
            >
              {t('pages.home.intro.contact_us')}
            </LinkWithLoaderAndScrolling>
          </div>

          <div className="col-12 col-sm-8 col-md-6 text-center p-3 p-xl-5">
            <img src={resumesImage} className="img-fluid" alt="family" />
          </div>
        </div>
      </div>
    </section>
  );
};

export default Intro;
