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
* Loading component.
*/

import React from 'react';

function Loading() {
  return (
    <div className="text-center align-middle">
      <div className="spinner-border"
           role="status">
        <span className="sr-only">Loading...</span>
      </div>
    </div>
  );
}

export default Loading;
