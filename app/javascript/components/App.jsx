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

import { withTranslation } from 'react-i18next';

import api from '../apis/prospero';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.api = api;
  }

  setLocale(locale, event) {
    event.preventDefault();
    this.api
        .locale()
        .update()
        .call({ locale: locale })
        .then(
          (success) => {
            this.props.i18n.changeLanguage(success.locale);
          }
        );
  }

  render() {
    const t = this.props.t;
    return (
      <Router>
        <Link to="#" onClick={this.setLocale.bind(this, 'en')}
                     style={{ marginRight: '10px'}}>
          English
        </Link>
        <Link to="#"onClick={this.setLocale.bind(this, 'fr')}>Français</Link>
        <ul>
          <li>
            <Link to="/">{t('menu.home')}</Link>
          </li>
          <li>
            <Link to="/sample/1">{t('menu.sample', { number: 1 })}</Link>
          </li>
          <li>
            <Link to="/sample/2">{t('menu.sample', { number: 2 })}</Link>
          </li>
          <li>
            <Link to="/sample/3">{t('menu.sample', { number: 3 })}</Link>
          </li>
        </ul>
        <Routes />
      </Router>
    );
  }
}

export default withTranslation()(App);
