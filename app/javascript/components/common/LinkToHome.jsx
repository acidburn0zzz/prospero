/**
* Prospero
*
* You should have received a copy of the license along with this program.
*
* Licensed under
* - GNU Affero General Public License V3
* - CeCILL Affero compliant
*/


import React               from 'react';
import { withTranslation } from 'react-i18next';

function LinkToSignUp(props) {
  return (
    <a href={ `/${props.i18n.language}`  }
       className={ props.className } >
      { props.t('pages.shared.home') }
    </a>
  );
}

export default withTranslation()(LinkToSignUp);
