#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# This script uses the GitLab API to create a new CI/CD Pipeline.
#
# See https://docs.gitlab.com/ee/api/pipelines.html#create-a-new-pipeline
#
# Usage:
#   create-pipeline.sh <options>
#
# Options:
#   --access-token        A Personal Access token authorized to create the merge request
#   --gitlab-url          GitLab instance URL
#   --project-name        GitLab project name (e.g prospero)
#   --project-namespace   GitLab project namespace (e.g prospero)
#   --pipeline-ref        Reference to commit
#   --pipeline-variables  Pipeline variables

# Make script to fail if any command fails
set -e

# Inspired from https://stackoverflow.com/questions/192249/
positional=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
  --access-token)
  access_token="$2"
  shift # past argument
  shift # past value
  ;;
  --gitlab-url)
  gitlab_url="$2"
  shift # past argument
  shift # past value
  ;;
  --project-name)
  project_name="$2"
  shift # past argument
  ;;
  --project-namespace)
  project_namespace="$2"
  shift # past argument
  ;;
  --pipeline-ref)
  pipeline_ref="$2"
  shift # past argument
  ;;
  --pipeline-variables)
  pipeline_variables="$2"
  shift # past argument
  ;;
  *)    # unknown option
  positional+=("$1") # save it in an array for later
  shift # past argument
  ;;
esac
done

echo "Creating pipeline..."
pipeline_response=$(curl -X POST \
  --header "PRIVATE-TOKEN: $access_token" \
  --header 'Content-Type: application/json' \
  --data "{ \"ref\": \"$pipeline_ref\", \"variables\": $pipeline_variables }" \
  --url $gitlab_url/api/v4/projects/$project_namespace%2F$project_name/pipeline 2> /dev/null)

  pipeline_id=$(echo $pipeline_response | jq -e -r ".id");
  echo "Pipeline created."
  echo $gitlab_url/$project_namespace/$project_name/merge_requests/$pipeline_id
