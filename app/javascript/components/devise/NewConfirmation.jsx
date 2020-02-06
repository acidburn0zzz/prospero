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
* New confirmation component.
*/

import React               from 'react';
import Page                from '../common/Page';
import Success             from './Success';
import Input               from '../common/Input';
import DeviseForm          from './DeviseForm';
import LinkToHome          from '../common/LinkToHome';
import LinkToSignIn        from './LinkToSignIn';
import LinkToSignUp        from './LinkToSignUp';
import { withTranslation } from 'react-i18next';

class NewConfirmation extends Page {
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
        .confirmations()
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
    return [
      <LinkToSignIn />,
      <LinkToSignUp />
    ];
  }

  render() {
    const t = this.props.t;
    if (this.state.submitted) {
      return (
        <Success>
          <div>{ t('pages.new_user_confirmation.success') }</div>
          <LinkToHome className="btn btn-primary btn-sm mt-4" />
        </Success>
      );
    } else {
      return (
        <DeviseForm submit={ t('pages.new_user_confirmation.submit') }
                    onSubmit={ this.handleSubmit }
                    links={ this.deviseLinks() }>
          <Input type="email"
                 model="user"
                 field="email"
                 required={ true } />
        </DeviseForm>
      );
    }
  }
}

export default withTranslation()(NewConfirmation);
