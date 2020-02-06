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
* Sign in component.
*/

import React                 from 'react';
import Page                  from '../common/Page';
import Input                 from '../common/Input';
import DeviseForm            from './DeviseForm';
import LinkToSignUp          from './LinkToSignUp';
import LinkToNewPassword     from './LinkToNewPassword';
import LinkToNewConfirmation from './LinkToNewConfirmation';
import { withTranslation }   from 'react-i18next';

class SignIn extends Page {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  initState() {
    this.state = {
      isSubmitting: false
    };
  }

  handleSubmit(event) {
    event.preventDefault();
    const formData = new FormData(event.target);
    this.setFlash(null);
    this.setState({ isSubmitting: true });
    this.api
        .auth()
        .create()
        .call(formData)
        .then(
          (response) => {
            if (response.error) {
              this.setFlash({ type: 'danger', message: response.error });
              this.setState({ isSubmitting: false });
            } else {
              location.href = '/app';
            }
          }
        );
  }

  deviseLinks() {
    return [
      <LinkToNewConfirmation />,
      <LinkToNewPassword />,
      <LinkToSignUp />
    ];
  }

  render() {
    const t = this.props.t;
    return (
      <DeviseForm submit={ t('pages.sign_in.submit') }
                  onSubmit={ this.handleSubmit }
                  links={ this.deviseLinks() }
                  isSubmitting={ this.state.isSubmitting } >
        <Input type="email"
               model="user"
               field="email"
               required={ true } />
        <Input type="password"
               model="user"
               field="password"
               required={ true } />
      </DeviseForm>
    );
  }
}

export default withTranslation()(SignIn);
