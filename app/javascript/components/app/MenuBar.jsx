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
* Application menu bar component.
*/

import React                   from 'react';
import api                     from '../../apis/prospero';
import Container               from '../common/Container';
import { Link, useRouteMatch } from 'react-router-dom';
import { withTranslation }     from 'react-i18next';

class MenuBar extends React.Component {
  constructor(props) {
    super(props);
    this.api = api;
    this.logout = this.logout.bind(this);
  }

  logout(event) {
    this.api
        .auth()
        .delete()
        .call()
        .then(() => location.href = '/');
  }

  render() {
    const t = this.props.t;
    return (
      <Container>
        <div className="row py-2">
          <div className="col-1">
            <strong>{ t('app.menu_bar.users') }</strong>
          </div>
          <div className="col-1 offset-10 text-right">
            <Link to="#"
                  onClick={ this.logout }
                  className="font-weight-bold">
              { t('app.menu_bar.logout') }
            </Link>
          </div>
        </div>
      </Container>
    );
  }
}

export default withTranslation()(MenuBar);
