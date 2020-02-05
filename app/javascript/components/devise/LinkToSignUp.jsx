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
import { Link }            from "react-router-dom";
import { withTranslation } from 'react-i18next';

function LinkToSignUp(props) {
  return (
    <Link to={ `/${props.i18n.language}/users/sign_up`  }
          className={ props.className } >
      { props.t('pages.shared.sign_up') }
    </Link>
  );
}

export default withTranslation()(LinkToSignUp);
