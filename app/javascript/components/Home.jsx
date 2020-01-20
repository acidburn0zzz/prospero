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
* Home page component.
*/

import React from 'react';
import { withTranslation } from 'react-i18next';

function Home({ t }) {
  return (
    <div className="home">
      <h1>{t('home.title')}</h1>
      <div>
        {t('home.description')}
      </div>
    </div>
  );
}

export default withTranslation()(Home);
