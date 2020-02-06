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

class Auth extends Resource {
  constructor(id) {
    super('/auth');
  }
}

export default Auth;
