/**
* Prospero
*
* You should have received a copy of the license along with this program.
*
* Licensed under
* - GNU Affero General Public License V3
* - CeCILL Affero compliant
*/

import Endpoint from './endpoint';

class Resource {
  constructor(path) {
    this.path = path;
  }

  create() {
    return new Endpoint('POST', this.path);
  }

  show() {
    return new Endpoint('GET', this.path);
  }

  update() {
    return new Endpoint('PUT', this.path);
  }

  destroy() {
    return new Endpoint('DELETE', this.path);
  }
}

export default Resource;
