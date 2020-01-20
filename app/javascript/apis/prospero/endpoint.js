/**
* Prospero
*
* You should have received a copy of the license along with this program.
*
* Licensed under
* - GNU Affero General Public License V3
* - CeCILL Affero compliant
*/

const basePath = '/api/v1';

const csrfParamTag = document.head.getElementsByTagName('meta')['csrf-param'];
const csrfTokenTag = document.head.getElementsByTagName('meta')['csrf-token'];

var ajaxDefaults = {};
ajaxDefaults[csrfParamTag.content] = csrfTokenTag.content;

class Endpoint {
  constructor(method, path) {
    this.method = method;
    this.path = basePath + path;
  }

  call(params) {
    return fetch(this.path, {
      method: this.method,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({...ajaxDefaults, ...params})
    })
    .then(response => response.json());
  }
}

export default Endpoint;
