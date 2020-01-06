#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# This script uses the GitLab API to create a merge request.
#
# See https://docs.gitlab.com/ee/api/merge_requests.html#create-mr
#
# Usage:
#   create-merge-request.sh <options>
#
# Options:
#   --access-token        A Personal Access token authorized to create the merge request
#   --assignee-id         Merge request's assignee user ID
#   --gitlab-url          GitLab instance URL
#   --project-name        GitLab project name (e.g prospero)
#   --project-namespace   GitLab project namespace (e.g lobster)
#   --source-branch       Merge request's source branch
#   --target-branch       Merge request's target branch

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
  --assignee-id)
  assignee_id="$2"
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
  --source-branch)
  source_branch="$2"
  shift # past argument
  ;;
  --target-branch)
  target_branch="$2"
  shift # past argument
  ;;
  *)    # unknown option
  positional+=("$1") # save it in an array for later
  shift # past argument
  ;;
esac
done

echo "Creating merge request..."
merge_request_response=$(curl -X POST \
  --header "PRIVATE-TOKEN: $access_token" \
  --form "source_branch=$source_branch" \
  --form "target_branch=$target_branch" \
  --form "assignee_id=$assignee_id" \
  --form "title=\"Automate merge of '$source_branch' into '$target_branch'\"" \
  --url $gitlab_url/api/v4/projects/$project_namespace%2F$project_name/merge_requests 2> /dev/null)

merge_request_iid=$(echo $merge_request_response | jq -e -r ".iid");
echo "Merge request created."
echo $gitlab_url/$project_namespace/$project_name/merge_requests/$merge_request_iid
