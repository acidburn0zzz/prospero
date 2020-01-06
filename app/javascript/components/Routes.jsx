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
* Navigation routes.
*
* See https://reacttraining.com/react-router/
*/

import React from 'react';
import { Switch, Route } from "react-router-dom";
import Home from './Home';
import Sample from './Sample';

function Routes() {
  return (
    <Switch>
      <Route path="/sample/:id">
        <Sample />
      </Route>
      <Route path="/">
        <Home />
      </Route>
    </Switch>
  );
}

export default Routes;
