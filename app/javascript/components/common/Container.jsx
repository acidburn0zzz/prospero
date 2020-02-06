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
* Base container component.
*/

import React from 'react';

function Container(props) {
  const containerClass = `container-fluid border rounded
                          bg-light border-secondary ${props.containerClass}`;
  return (
    <div className="m-3">
      <div className={ containerClass }>
        { props.children }
      </div>
    </div>
  );
}

export default Container;
