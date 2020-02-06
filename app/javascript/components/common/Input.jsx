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
* Form input component.
*/

import React               from 'react';
import { withTranslation } from 'react-i18next';

function Input(props) {
  const t = props.t;
  const id = props.model + '_input_' + props.field;
  const className = 'form-control' + (props.error ? ' is-invalid': '');
  return (
    <div className="form-group">
      <label htmlFor={ id }>
        { props.label || t('activerecord.attributes.' + props.model + '.' + props.field) }
      </label>
      <input id={ id }
             type={ props.type }
             name={ props.model + '[' + props.field + ']' }
             required={ props.required }
             className={ className } />
      {
        props.error &&
          props.error.map((value, index) =>
            <div className="invalid-feedback" key={ index }>
              { value }
            </div>
          )
      }
    </div>
  );
}

export default withTranslation()(Input);
