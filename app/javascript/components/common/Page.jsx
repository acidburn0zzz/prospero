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
* React subcomponent.
*/

import api           from '../../apis/prospero';
import { Component } from 'react';

class Page extends Component {
  constructor(props) {
    super(props);
    props.setFlash && props.setFlash(null);
    this.setFlash = props.setFlash;
    this.api = api;
    this.initState && this.initState.bind(this)();
  }
}

export default Page;
