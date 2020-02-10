/**
* Prospero
*
* You should have received a copy of the license along with this program.
*
* Licensed under
* - GNU Affero General Public License V3
* - CeCILL Affero compliant
*/

/**
* Language switch component.
*/

import React                   from 'react';
import { Link, useLocation, useRouteMatch } from 'react-router-dom';

const localeNames = {
  de: 'Deutsch',
  en: 'English',
  es: 'Castellano',
  fr: 'Français',
  'pt-BR': 'Português (Brasil)'
};

function LanguagesDropdown(props) {
  const unlocalizedPath = useLocation().pathname.split('/').splice(2).join('/');
  const currentLocale = useRouteMatch().params.locale;
  return (
    <div className="nav-item dropdown">
      <a className="dropdown-toggle" href="#" data-toggle="dropdown">
        { localeNames[currentLocale] }
      </a>
      <div className="dropdown-menu">
        {
          Object.keys(localeNames).map((locale) =>
            locale !== currentLocale &&
              <a key={ locale }
                 href={ `/${locale}/${unlocalizedPath}` }
                 className="dropdown-item" >
                { localeNames[locale] }
              </a>
          )
        }
      </div>
    </div>
  );
}

export default LanguagesDropdown;
