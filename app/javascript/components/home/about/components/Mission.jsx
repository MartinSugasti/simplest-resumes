import React from 'react';
import i18n from '../../../shared/i18n';

import missionImage from '../../../../images/others/mission.png';

const Mission = () => (
  <section id="mission" className="bg-primary">
    <div className="container-lg py-5">
      <div className="row mx-0 justify-content-around align-items-center">
        <div className="col-11 col-sm-9 col-md-6 text-center">
          <div className="accordion accordion-flush panel-group" id="accordionFlushExample">
            <div className="accordion-item panel bg-transparent border border-2 border-light">
              <h2 className="accordion-header panel-heading" id="flush-headingOne">
                <button
                  className="accordion-button collapsed panel-title rounded-2 text-center bg-transparent"
                  type="button"
                  data-bs-toggle="collapse"
                  data-bs-target="#flush-collapseOne"
                  aria-expanded="false"
                  aria-controls="flush-collapseOne"
                >
                  {i18n.t('pages.about_us.mission.title_1')}
                  <span> </span>
                </button>
              </h2>
              <div
                id="flush-collapseOne"
                className="accordion-collapse collapse panel-collapse"
                aria-labelledby="flush-headingOne"
                data-bs-parent="#accordionFlushExample"
              >
                <div className="accordion-body text-light py-0 px-2 fst-italic">
                  {i18n.t('pages.about_us.mission.description_1')}
                </div>
                <div className="accordion-body text-light px-2 fst-italic">
                  {i18n.t('pages.about_us.mission.description_2')}
                </div>
              </div>
            </div>
            <div className="accordion-item panel bg-transparent border border-2 border-light">
              <h2 className="accordion-header panel-heading" id="flush-headingTwo">
                <button
                  className="accordion-button collapsed panel-title rounded-2 text-center bg-transparent"
                  type="button"
                  data-bs-toggle="collapse"
                  data-bs-target="#flush-collapseTwo"
                  aria-expanded="false"
                  aria-controls="flush-collapseTwo"
                >
                  {i18n.t('pages.about_us.mission.title_2')}
                  <span> </span>
                </button>
              </h2>
              <div
                id="flush-collapseTwo"
                className="accordion-collapse collapse panel-collapse"
                aria-labelledby="flush-headingTwo"
                data-bs-parent="#accordionFlushExample"
              >
                <div className="accordion-body text-light px-2 pt-0 fst-italic">
                  {i18n.t('pages.about_us.mission.description_3')}
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="col-12 col-md-6 order-md-first text-center align-self-end mb-n5">
          <img src={missionImage} className="img-fluid" alt="mission" />
        </div>
      </div>
    </div>
  </section>
);

export default Mission;
