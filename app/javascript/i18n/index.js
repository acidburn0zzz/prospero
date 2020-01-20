/**
* Prospero
*
* You should have received a copy of the license along with this program.
*
* Licensed under
* - GNU Affero General Public License V3
* - CeCILL Affero compliant
*/

import i18n from 'i18next';
import XHR from 'i18next-xhr-backend';
import { initReactI18next, withTranslation } from 'react-i18next';
import translations from './translations';

i18n
  // load translation using xhr -> see /public/locales
  // learn more: https://github.com/i18next/i18next-xhr-backend
  .use(XHR)
  // pass the i18n instance to react-i18next.
  .use(initReactI18next)
  // init i18next
  // for all options read: https://www.i18next.com/overview/configuration-options
  .init({
    fallbackLng: 'en',
    lng: document.getElementsByTagName('html')[0].attributes.lang.value,
    resources: {
      en: { translation: translations['en'] },
      fr: { translation: translations['fr'] }
    }
  });

export default i18n;
