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
* Application component.
*/

import React   from 'react';
import MenuBar from './MenuBar';
import Library from './Library';
import {
  Switch,
  Route,
  Redirect,
  BrowserRouter as Router
} from 'react-router-dom';

function Index(props) {
  return (
    <Router>
      <MenuBar />
      <Switch>
        <Route path="/app/directories/:directoryId">
          <Library setState={ props.setFlash }
                   currentUserId={ props.currentUserId } />
        </Route>
        <Route path="/app/directories">
          <Library setState={ props.setFlash }
                   currentUserId={ props.currentUserId } />
        </Route>
        <Route path="/app">
          <Redirect to="/app/directories" />
        </Route>
      </Switch>
    </Router>
  );
}

export default Index;
