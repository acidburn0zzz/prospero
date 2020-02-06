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
* Edit confirmation component.
*/

import React                   from 'react';
import Page                    from '../common/Page';
import Loading                 from '../common/Loading';
import LinkToSignIn            from './LinkToSignIn';
import { parse as parseQuery } from 'query-string';
import { withTranslation }     from 'react-i18next';
import api                     from '../../apis/prospero';

class EditConfirmation extends Page {
  constructor(props) {
    super(props);
    this.updateConfirmation.bind(this)();
  }

  initState() {
    this.state = {
      error: null,
      isLoaded: false,
      isSuccessfull: false
    };
  }

  updateConfirmation() {
    const formData = new FormData();
    formData.append('token', parseQuery(location.search)['confirmation_token']);
    this.api
        .users()
        .confirmations()
        .update()
        .call(formData)
        .then(
          (response) => {
            this.setState({
              isLoaded: true,
              error: response.error,
            });
          }
        );
  }

  render() {
    const t = this.props.t;
    if (this.state.isLoaded) {
      if (this.state.error) {
        const errorKeys = Object.keys(this.state.error);
        return (
          <div className="container">
            <div className="text-center">
              {
                errorKeys.map((key, index) => {
                  return (
                    <h4>
                      {
                        t('activerecord.attributes.user.' + key) + ' ' +
                        this.state.error[key]
                      }
                    </h4>
                  );
                })
              }
            </div>
            <div className="text-center mt-4">
              <LinkToSignIn className="btn btn-primary" />
            </div>
          </div>
        );
      } else {
        return (
          <div className="container">
            <div className="text-center">
              <h4>{ t('pages.edit_user_confirmation.success') }</h4>
            </div>
            <div className="text-center mt-4">
              <LinkToSignIn className="btn btn-primary" />
            </div>
          </div>
        );
      }
    } else {
      return <Loading />
    }
  }
}

export default withTranslation()(EditConfirmation);
