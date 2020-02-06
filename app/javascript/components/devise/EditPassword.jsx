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
* Edit password component.
*/

import React                   from 'react';
import Page                    from '../common/Page';
import Input                   from '../common/Input';
import Loading                 from '../common/Loading';
import Success                 from './Success';
import DeviseForm              from './DeviseForm';
import LinkToSignIn            from './LinkToSignIn';
import { withTranslation }     from 'react-i18next';
import { parse as parseQuery } from 'query-string';

class EditPassword extends Page {
  constructor(props) {
    super(props);
    this.state = {
      error: null,
      submitted: false,
      isSubmitting: false
    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.validate = this.validate.bind(this);
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
      return false;
    }
  }

  handleSubmit(event) {
    event.preventDefault();
    const formData = new FormData(event.target);
    if (this.validate(formData)) {
      formData.append('token', parseQuery(location.search)['reset_password_token']);
      this.setState({
        error: null,
        submitted: false,
        isSubmitting: true
      });
      this.api
          .users()
          .passwords()
          .update()
          .call(formData)
          .then(
            (response) => {
              this.setState({
                error: response.error,
                submitted: true,
                isSubmitting: false
              });
              if (response.error && response.error['reset_password_token']) {
                this.setFlash({
                  type: 'danger',
                  message: (
                    this.props.t('activerecord.attributes.user.reset_password_token') + ' ' +
                    response.error['reset_password_token']
                  )
                });
              }
            }
          );
    }
  }

  render() {
    const t = this.props.t;
    if (this.state.submitted && !this.state.error) {
      return (
        <Success>
          <div>{ t('pages.edit_user_password.success') }</div>
          <LinkToSignIn className="btn btn-primary btn-sm mt-4" />
        </Success>
      );
    } else {
      const error = this.state.error || {};
      return (
        <DeviseForm submit={ t('pages.edit_user_password.submit') }
                    onSubmit={ this.handleSubmit }
                    isSubmitting={ this.state.isSubmitting } >
          <Input type="password"
                 model="user"
                 field="password"
                 label={ t('pages.edit_user_password.password') }
                 required={ true }
                 error={ error['password'] } />
          <Input type="password"
                 model="user"
                 field="password_confirmation"
                 label={ t('pages.edit_user_password.password_confirmation') }
                 required={ true }
                 error={ error['password_confirmation'] } />
        </DeviseForm>
      );
    }
  }
}

export default withTranslation()(EditPassword);
