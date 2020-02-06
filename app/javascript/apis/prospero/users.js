/**
* Prospero
*
* You should have received a copy of the license along with this program.
*
* Licensed under
* - GNU Affero General Public License V3
* - CeCILL Affero compliant
*/

import Resource from './resource';

class Users extends Resource {
  constructor(id) {
    id ? super('/users/' + id) : super('/users');
    this.id = id;
  }

  confirmations() {
    return new Resource(this.path + '/confirmations');
  }

  passwords() {
    return new Resource(this.path + '/passwords');
  }
}

export default Users;
