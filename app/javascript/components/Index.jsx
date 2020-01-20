/**
* Prospero
*
* You should have received a copy of the license along with this program.
*
* Licensed under
* - GNU Affero General Public License V3
* - CeCILL Affero compliant
*/

import React from 'react';
import App from './App';

class Index extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isLoaded: false
    }
    import('../i18n')
      .then(module => this.setState({ isLoaded: true }));
  }

  render() {
    return this.state.isLoaded ? <App /> : <div>Loading...</div>;
  }
}

export default Index;
