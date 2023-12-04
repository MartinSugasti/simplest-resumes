import React from 'react';
import { useTranslation } from 'react-i18next';

const QualityPolicy = () => {
  const { t } = useTranslation();

  return (
    <section id="quality-policy" className="bg-light">
      <div className="container-lg py-5">
        <div className="text-center text-dark">
          <h1>{t('pages.about_us.quality_policy.title')}</h1>
          <div className="mt-4 px-3 px-sm-5 fst-italic">
            <p>{t('pages.about_us.quality_policy.description_1')}</p>

            <p>{t('pages.about_us.quality_policy.description_2')}</p>

            <p>{t('pages.about_us.quality_policy.description_3')}</p>

            <p>{t('pages.about_us.quality_policy.description_4')}</p>

            <p>{t('pages.about_us.quality_policy.description_5')}</p>

            <p className="text-end">{t('pages.about_us.quality_policy.date')}</p>
          </div>
        </div>
      </div>
    </section>
  );
};

export default QualityPolicy;
