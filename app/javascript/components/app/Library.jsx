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
* Library component.
*/

import React from 'react';
import Page                    from '../common/Page';
import Container               from '../common/Container';
import { withTranslation }     from 'react-i18next';
import { Link, useRouteMatch } from 'react-router-dom';

function LibraryBox(props) {
  const selectedDirectoryId = useRouteMatch().params.directoryId
  return (
    <div className="row container-box">
      <DirectoriesTree t={ props.t }
                       18n={ props.i18n }
                       directoriesTree={ props.directoriesTree }
                       selectedDirectoryId={ selectedDirectoryId } />
    </div>
  );
}

function DirectoriesList(props) {
  const directories = props.directories;
  directories.sort((first, second) => {
    return first.name.localeCompare(
      second.name, i18n.language, { sensitivity: 'base' }
    );
  });
  const topLevel = directories.filter((directory) => {
    return !directory.parent_id;
  });
  const tree = directories.reduce((map, directory) => {
    if (directory.parent_id) {
      map[directory.parent_id] ||= []
      map[directory.parent_id].push(directory)
    }
  }, {});
  return (
    <div className="col-4 py-2 border-right border-secondary list">
    </div>
  );
}

class Library extends Page {
  constructor(props) {
    super(props)
    this.loadDirectories.bind(this)();
    this.directoriesListToTree = this.directoriesListToTree.bind(this);
  }

  loadDirectories() {
    this.api
        .directories()
        .call()
        .then(
          (response) => {
            if (response.directories) {
              this.setState({
                directoriesTree: this.directoriesListToTree(directories)
              });
            }
          }
        );
  }

  directoriesListToTree(directories) {
    directories.sort((first, second) => {
      return first.name.localeCompare(
        second.name, this.props.i18n.language, { sensitivity: 'base' }
      );
    });
    const childrenMap = directories.reduce((map, directory) => {
      if (directory.parent_id) {
        map[directory.parent_id] |= [];
        map[directory.parent_id].push(directory);
      }
    }, {});
    directories.forEach((directory) => {
      directory.children = childrenMap[directory.id];
    });
    return directories;
  }

  render() {
    return (
      <Container containerClass="list-container">
      </Container>
    );
  }
}

export default withTranslation()(Library);
