import i18next from 'i18next';
import { initReactI18next } from 'react-i18next';

import translations from '../../../locales/translations.json';

const englishTranslations = translations.en;
const spanishTranslations = translations.es;

i18next
  .use(initReactI18next)
  .init({
    lng: document.querySelector('body').dataset.locale || 'en',
    fallbackLng: 'en',
    resources: {
      en: { translation: englishTranslations },
      es: { translation: spanishTranslations }
    }
  });
