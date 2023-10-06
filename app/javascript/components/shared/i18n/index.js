import { I18n } from 'i18n-js';
import translations from '../../../locales/translations.json';

const i18n = new I18n(translations);
console.log('configuring i18n');

i18n.locale = document.querySelector('body').dataset.locale || 'en';
i18n.defaultLocale = document.querySelector('body').dataset.locale || 'en';

export default i18n;
