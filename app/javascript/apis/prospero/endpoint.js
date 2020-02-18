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

class Endpoint {
  constructor(method, path) {
    this.method = method;
    this.path = basePath + path;
    this.csrfParamTag =
      document.head.getElementsByTagName('meta')['csrf-param'].content;
    this.csrfTokenTag =
      document.head.getElementsByTagName('meta')['csrf-token'].content;
  }

  call(formData) {
    if (!formData && this.method !== 'GET') {
      formData = new FormData();
    }
    formData && formData.append(this.csrfParamTag, this.csrfTokenTag);
    return fetch(this.path, {
      method: this.method,
      body: formData,
      headers: {
        Accept: 'application/json'
      }
    })
    .then(response => response.json());
  }
}

export default Endpoint;
