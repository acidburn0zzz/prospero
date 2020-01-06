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

function Sample() {
  let { id } = useParams();
  return (
    <div className="sample">
      <h1>Sample page</h1>
      <div>
        This is a sample page.
      </div>
      <div>
        The given Id in the URL is: <strong>{id}</strong>
      </div>
    </div>
  );
}

export default Sample;
