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
* Devise form component.
*/

import React   from 'react';
import Loading from '../common/Loading';

function DeviseForm(props) {
  const links = props.links || [];
  return (
    <div className="container">
      { props.isSubmitting && <Loading /> }
      <div className={ props.isSubmitting ? 'd-none' : undefined }>
        <div className="row">
          <form onSubmit={ props.onSubmit }
                className="col-4 offset-4 bg-light border py-3 border-secondary rounded" >
            { props.children }
            <div className="text-right">
              <button type="submit" className="btn btn-primary">
                { props.submit }
              </button>
            </div>
          </form>
        </div>
        <div className="mt-2">
          {
            links.map((link, index) =>
              <div className="row" key={ index }>
                <div className="col-4 offset-4 text-right">
                  { link }
                </div>
              </div>
            )
          }
        </div>
      </div>
    </div>
  );
}

export default DeviseForm;
