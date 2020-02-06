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
* Succcess message component.
*/

import React from 'react';

function Succcess(props) {
  return (
    <div className="container">
      <div className="row">
        <div className="col-6 offset-3 text-center">
          { props.children }
        </div>
      </div>
    </div>
  );
}

export default Succcess;
