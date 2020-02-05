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
import Users   from './Users';
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
        <Route path="/app/users/:id">
          <Users setState={ props.setFlash }
                 currentUserId={ props.currentUserId } />
        </Route>
        <Route path="/app/users">
          <Users setState={ props.setFlash }
                 currentUserId={ props.currentUserId } />
        </Route>
        <Route path="/app">
          <Redirect to="/app/users" />
        </Route>
      </Switch>
    </Router>
  );
}

export default Index;
