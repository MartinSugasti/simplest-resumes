import { I18n } from 'i18n-js';
import translations from '../../../locales/translations.json';

const i18n = new I18n(translations);

i18n.locale = document.documentElement.lang || 'en';
i18n.defaultLocale = document.documentElement.lang || 'en';

export default i18n;
