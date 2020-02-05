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
* Sign up component.
*/

import React                      from 'react';
import Page                       from '../common/Page';
import Input                      from '../common/Input';
import Success                    from './Success';
import DeviseForm                 from './DeviseForm';
import LinkToHome                 from '../common/LinkToHome';
import LinkToSignIn               from './LinkToSignIn';
import { withTranslation, Trans } from 'react-i18next';

class SignUp extends Page {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.validate = this.validate.bind(this);
  }

  initState() {
    this.state = {
      error: null,
      createdUser: null,
      isSubmitting: null
    };
  }

  validate(formData) {
    const t = this.props.t;
    if (formData.get('user[password]') ===
          formData.get('user[password_confirmation]')) {
      return true;
    } else {
      this.setState({
        error: {
          password_confirmation: [
            t('errors.messages.password_confirmation_missmatch')
          ]
        }
      });
      return false
    }
  }

  handleSubmit(event) {
    event.preventDefault(); // Avoid default event
    const formData = new FormData(event.target);
    if (this.validate(formData)) {
      this.setState({ createdUser: null, error: null, isSubmitting: true });
      this.api
          .users()
          .create()
          .call(new FormData(event.target))
          .then(
            (response) => {
              this.setState({
                error: response.error,
                createdUser: response.user,
                isSubmitting: false
              });
            }
          );
    }
  }

  deviseLinks() {
    return [<LinkToSignIn />];
  }

  render() {
    const t = this.props.t;
    if (this.state.createdUser) {
      const email = this.state.createdUser.email;
      return (
        <Success>
          <div>
            <Trans i18nKey="pages.sign_up.success" email={ email }>
              A confirmation e-mail will be sent to <strong>{{email}}</strong>
            </Trans>
          </div>
          <LinkToHome className="btn btn-primary btn-sm mt-4" />
        </Success>
      );
    } else {
      const error = this.state.error || {};
      return (
        <DeviseForm submit={ t('pages.sign_up.submit') }
                    onSubmit={ this.handleSubmit }
                    links={ this.deviseLinks() }
                    isSubmitting={ this.state.isSubmitting } >
          <input type="hidden"
                 name="locale"
                 value={ this.props.i18n.language } />
          <Input type="text"
                 model="user"
                 field="full_name"
                 required={ true }
                 error={ error['full_name'] } />
          <Input type="email"
                 model="user"
                 field="email"
                 required={ true }
                 error={ error['email'] } />
          <Input type="password"
                 model="user"
                 field="password"
                 required={ true }
                 error={ error['password'] } />
          <Input type="password"
                 model="user"
                 field="password_confirmation"
                 required={ true }
                 error={ error['password_confirmation'] } />
        </DeviseForm>
      );
    }
  }
}

export default withTranslation()(SignUp);
