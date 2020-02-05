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
* Flash messages component.
*/

import React from 'react';

function Flash(props) {
  const className = 'alert alert-' + props.type;
  return (
    <div className={ className } role="alert">
      { props.message }
    </div>
  );
}

export default Flash;
