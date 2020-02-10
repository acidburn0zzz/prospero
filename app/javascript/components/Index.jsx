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
* React entrypoint.
*/

import React, { Suspense, lazy } from 'react';
import Flash                     from './common/Flash';
import Placeholder               from './common/Placeholder';

const App               = lazy(() => import('./app/Index'));
const SignIn            = lazy(() => import('./devise/SignIn'));
const SignUp            = lazy(() => import('./devise/SignUp'));
const NewPassword       = lazy(() => import('./devise/NewPassword'));
const EditPassword      = lazy(() => import('./devise/EditPassword'));
const NewConfirmation   = lazy(() => import('./devise/NewConfirmation'));
const EditConfirmation  = lazy(() => import('./devise/EditConfirmation'));
const Route             = lazy(() => import('react-router-dom').then(module => ({ default: module.Route })));
const Switch            = lazy(() => import('react-router-dom').then(module => ({ default: module.Switch })));
const Router            = lazy(() => import('react-router-dom').then(module => ({ default: module.BrowserRouter })));
const Redirect          = lazy(() => import('react-router-dom').then(module => ({ default: module.Redirect })));

class Index extends React.Component {
  constructor(props) {
    super(props);
    this.state = { isLoaded: false, flash: null };
    this.setFlash = this.setFlash.bind(this);
    import('../i18n')
      .then(
        (module) => {
          var i18n = module.default;
          i18n
            // init i18next
            // for all options read: https://www.i18next.com/overview/configuration-options
            .init({
              load: 'currentOnly',
              fallbackLng: 'en',
              lng: this.props.locale
            },
            () => this.setState({ isLoaded: true }));
        }
      )
  }

  setFlash(flash) {
    this.setState({ flash: flash });
  }

  render() {
    const flash = this.state.flash;
    if (this.state.isLoaded) {
      const currentUserId = this.props.currentUserId;
      return (
        <Suspense fallback={ <Placeholder /> }>
          <Router>
            { flash && <Flash type={ flash.type } message={ flash.message } /> }
            <Switch>
              <Route path="/:locale/users/sign_up">
                {
                  currentUserId ?
                    <Redirect to="/app" /> :
                    <SignUp setFlash={ this.setFlash } />
                }
              </Route>
              <Route path="/:locale/users/sign_in">
                {
                  currentUserId ?
                    <Redirect to="/app" /> :
                    <SignIn setFlash={ this.setFlash } />
                }
              </Route>
              <Route path="/:locale/users/confirmations/new">
                {
                  currentUserId ?
                    <Redirect to="/app" /> :
                    <NewConfirmation setFlash={ this.setFlash } />
                }
              </Route>
              <Route path="/:locale/users/confirmations/edit">
                {
                  currentUserId ?
                    <Redirect to="/app" /> :
                    <EditConfirmation setFlash={ this.setFlash } />
                }
              </Route>
              <Route path="/:locale/users/passwords/new">
                {
                  currentUserId ?
                    <Redirect to="/app" /> :
                    <NewPassword setFlash={ this.setFlash } />
                }
              </Route>
              <Route path="/:locale/users/passwords/edit">
                {
                  currentUserId ?
                    <Redirect to="/app" /> :
                    <EditPassword setFlash={ this.setFlash } />
                }
              </Route>
              <Route path="/app">
                {
                  currentUserId ?
                    <App setFlash={ this.setFlash }
                         currentUserId={ currentUserId } /> :
                    <Redirect to={ `/${this.props.locale}/users/sign_in` } />
                }
              </Route>
            </Switch>
          </Router>
        </Suspense>
      );
    } else {
      return <Placeholder />
    }
  }
}

export default Index;
