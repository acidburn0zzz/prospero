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
* React application entrypoint.
*/

import React from 'react';
import { BrowserRouter as Router, Link } from "react-router-dom";
import Routes from './Routes';

function App() {
  return (
    <Router>
      <ul>
        <li>
          <Link to="/">Home</Link>
        </li>
        <li>
          <Link to="/sample/1">Test link 1</Link>
        </li>
        <li>
          <Link to="/sample/2">Test link 2</Link>
        </li>
        <li>
          <Link to="/sample/3">Test link 3</Link>
        </li>
      </ul>
      <Routes />
    </Router>
  );
}

export default App;
