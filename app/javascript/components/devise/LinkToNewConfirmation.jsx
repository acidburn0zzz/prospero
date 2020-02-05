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

function LinkToNewConfirmation(props) {
  return (
    <Link to={ `/${props.i18n.language}/users/confirmations/new` }
          className={ props.className } >
      { props.t('pages.shared.new_user_confirmation') }
    </Link>
  );
}

export default withTranslation()(LinkToNewConfirmation);
