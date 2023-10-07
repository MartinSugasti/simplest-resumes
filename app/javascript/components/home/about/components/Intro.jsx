import React from 'react';
import { useTranslation } from 'react-i18next';

import teamImage from '../../../../images/others/team.png';

const Intro = () => {
  const { t } = useTranslation();

  return (
    <section id="about-us-intro" className="bg-light">
      <div className="container-lg py-5">
        <div className="row mx-0 g-4 justify-content-around align-items-center">
          <div className="col-md-4 order-md-2 text-center mt-4 mt-md-0">
            <h1 className="text-dark mb-0">{t('pages.about_us.intro.title')}</h1>
            <p className="text-muted mb-2 fst-italic">{t('pages.about_us.intro.subtitle')}</p>
          </div>
          <div className="col-10 col-sm-8 col-md-6 order-md-1 text-center">
            <img src={teamImage} className="img-fluid" alt="team" />
          </div>
        </div>
      </div>
    </section>
  );
};

export default Intro;
