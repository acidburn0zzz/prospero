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
* New password component.
*/

import React               from 'react';
import Page                from '../common/Page';
import Input               from '../common/Input';
import Loading             from '../common/Loading';
import Success             from './Success';
import DeviseForm          from './DeviseForm';
import LinkToHome          from '../common/LinkToHome';
import LinkToSignIn        from './LinkToSignIn';
import LinkToSignUp        from './LinkToSignUp';
import { withTranslation } from 'react-i18next';

class NewPassword extends Page {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  initState() {
    this.state = {
      submitted: false,
      isSubmitting: false
    };
  }

  handleSubmit(event) {
    event.preventDefault();
    const formData = new FormData(event.target);
    this.setState({ submitted: false, isSubmitting: true });
    this.api
        .users()
        .passwords()
        .create()
        .call(formData)
        .then(
          () => {
            this.setState({
              submitted: true,
              isSubmitting: false
            });
          }
        );
  }

  deviseLinks() {
    return [<LinkToSignIn />, <LinkToSignUp />];
  }

  render() {
    const t = this.props.t;
    if (this.state.submitted) {
      return (
        <Success>
          <div>{ t('pages.new_user_password.success') }</div>
          <LinkToHome className="btn btn-primary btn-sm mt-4" />
        </Success>
      );
    } else {
      return (
        <DeviseForm submit={ t('pages.new_user_password.submit') }
                    onSubmit={ this.handleSubmit }
                    links={ this.deviseLinks() }
                    isSubmitting={ this.state.isSubmitting } >
          <Input type="email"
                 model="user"
                 field="email"
                 required={ true } />
        </DeviseForm>
      );
    }
  }
}

export default withTranslation()(NewPassword);
