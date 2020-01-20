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
* Sample pages component.
*/

import React from 'react';
import { useParams } from 'react-router-dom';
import { withTranslation } from 'react-i18next';

function Sample({ t }) {
  let { id } = useParams();
  return (
    <div className="sample">
      <h1>{t('sample.title')}</h1>
      <div>
        {t('sample.description.0')}
      </div>
      <div>
        {t('sample.description.1')} <strong>{id}</strong>
      </div>
    </div>
  );
}

export default withTranslation()(Sample);
