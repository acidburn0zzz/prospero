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
* Users component.
*/

import React                   from 'react';
import api                     from '../../apis/prospero';
import Page                    from '../common/Page';
import Loading                 from '../common/Loading';
import Container               from '../common/Container';
import { withTranslation }     from 'react-i18next';
import { Link, useRouteMatch } from 'react-router-dom';

function UsersBox(props) {
  const t = props.t;
  const users = props.users;
  const currentUserId = props.currentUserId;
  let selectedUserId = useRouteMatch().params.id;
  return (
    <div className="row users-box" >
      <UsersList t={ t }
                 users={ users }
                 currentUserId={ currentUserId }
                 selectedUserId={ selectedUserId } />
      { selectedUserId && <User t={ props.t } id={ selectedUserId } /> }
    </div>
  );
}

function UsersList(props) {
  const users = props.users;
  const currentUserId = props.currentUserId
  const selectedUserId = props.selectedUserId;
  return (
    <div className="col-4 py-2 border-right border-secondary users-list">
      {
        users.map((user) =>
          <UsersListItem t={ props.t }
                         user={ user }
                         key={ user.id }
                         isSelected={ user.id === selectedUserId }
                         isCurrentUser={ user.id === currentUserId } />
        )
      }
    </div>
  );
}

class User extends React.Component {
  constructor(props) {
    super(props);
    this.api = api;
    this.initState.bind(this)();
    this.loadUser.bind(this)();
  }

  initState() {
    this.state = { user: null };
  }

  loadUser() {
    this.api
        .users(this.props.id)
        .show()
        .call()
        .then((response) => this.setState({ user: response.user }));
  }

  render() {
    const t = this.props.t;
    const user = this.state.user;
    return (
      <div className="col-8 py-2">
        {
          user &&
            <div className="p-2">
              <h3 className="mb-4">
                { user.full_name }
              </h3>
              <h5>
                { t('activerecord.attributes.user.email') }
              </h5>
              <div>
                { user.email }
              </div>
            </div>
        }
      </div>
    );
  }
}

function UsersListItem(props) {
  const t = props.t;
  const user = props.user;
  const isSelected = props.isSelected;
  const isCurrentUser = props.isCurrentUser;
  return (
    <div>
      {
        isSelected ?
          <strong>{ user.full_name }</strong> :
          <Link className="font-weight-bold"
                to={ `/app/users/${user.id}` } >
            { user.full_name }
          </Link>
      } {
        isCurrentUser ? `(${t('activerecord.attributes.user.you')})` : ''
      }
    </div>
  );
}

class Users extends Page {
  constructor(props) {
    super(props)
    this.loadUsers.bind(this)();
  }

  initState() {
    this.state = { users: [] };
  }

  loadUsers() {
    this.api
        .users()
        .index()
        .call()
        .then(
          (response) => {
            this.setState({ users: response.map((element) => element.user)});
          }
        );
  }

  render() {
    return (
      <Container containerClass="users-container">
        {
          <UsersBox t={ this.props.t }
                    users={ this.state.users }
                    currentUserId={ this.props.currentUserId } />
        }
      </Container>
    );
  }
}

export default withTranslation()(Users);
