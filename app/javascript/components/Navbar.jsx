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
* Navbar component.
*/

import React, { Suspense, lazy } from 'react';
import Placeholder               from './common/Placeholder';

const LanguagesDropdown = lazy(() => import('./common/LanguagesDropdown'));
const Link              = lazy(() => import('react-router-dom').then(module => ({ default: module.Link })));
const Route             = lazy(() => import('react-router-dom').then(module => ({ default: module.Route })));
const Switch            = lazy(() => import('react-router-dom').then(module => ({ default: module.Switch })));
const Router            = lazy(() => import('react-router-dom').then(module => ({ default: module.BrowserRouter })));

function Navbar(props) {
  return (
    <nav className="navbar navbar-expand navbar-dark fixed-top bg-dark">
      <a className="navbar-brand" href={ `/${props.locale}` }>
        Prospéro
      </a>
      {
        props.currentUserId ?
          undefined :
          <Suspense fallback={ <Placeholder /> }>
            <Router>
              <Switch>
                <Route path="/app">
                </Route>
                <Route path="/:locale">
                  <LanguagesDropdown />
                </Route>
              </Switch>
            </Router>
          </Suspense>
      }
    </nav>
  );
}

export default Navbar;
