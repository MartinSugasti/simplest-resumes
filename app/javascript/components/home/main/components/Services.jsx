import React from 'react';
import { useTranslation } from 'react-i18next';

const Services = () => {
  const { t } = useTranslation();

  return (
    <section id="services" className="bg-primary">
      <div className="container-lg py-5">
        <div className="text-center">
          <h1 className="text-light mb-0">{t('pages.home.services.title')}</h1>
          <p className="text-light mb-2 fst-italic">{t('pages.home.services.subtitle')}</p>
        </div>

        <div className="row mx-0 gy-4 justify-content-center mt-4">
          <div className="col-10 col-sm-5 col-md-4 col-xl-3">
            <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
              <div className="card-body">
                <div className="mb-4">
                  <i className="bi fa-2x bi-alphabet" />
                  <h5 className="card-title">{t('pages.home.services.effective_resumes.title')}</h5>
                </div>
                <div>
                  <p className="card-text">
                    {t('pages.home.services.effective_resumes.description')}
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div className="col-10 col-sm-5 col-md-4 col-xl-3 me-xl-1">
            <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
              <div className="card-body">
                <div className="mb-4">
                  <i className="bi fa-2x bi-search" />
                  <h5 className="card-title">{t('pages.home.services.search_optimization.title')}</h5>
                </div>
                <div>
                  <p className="card-text">
                    {t('pages.home.services.search_optimization.description')}
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div className="col-10 col-sm-5 col-md-4 col-xl-3">
            <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
              <div className="card-body">
                <div className="mb-4">
                  <i className="bi fa-2x bi-card-checklist" />
                  <h5 className="card-title">{t('pages.home.services.postulations_managment.title')}</h5>
                </div>
                <div>
                  <p className="card-text">
                    {t('pages.home.services.postulations_managment.description')}
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div className="col-10 col-sm-5 col-md-4 col-xl-3">
            <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
              <div className="card-body">
                <div className="mb-4">
                  <i className="bi fa-2x bi-currency-dollar" />
                  <h5 className="card-title">{t('pages.home.services.free.title')}</h5>
                </div>
                <div>
                  <p className="card-text">
                    {t('pages.home.services.free.description')}
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div className="col-10 col-sm-5 col-md-4 col-xl-3">
            <div className="card bg-light rounded-4 text-center border-0 shadow-lg h-100">
              <div className="card-body">
                <div className="mb-4">
                  <i className="bi fa-2x bi-magic" />
                  <h5 className="card-title">{t('pages.home.services.simplicity.title')}</h5>
                </div>
                <div>
                  <p className="card-text">
                    {t('pages.home.services.simplicity.description')}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Services;
