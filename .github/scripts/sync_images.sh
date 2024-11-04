#!/bin/bash

set -euo pipefail

ECR_URI="$1"

# Retrieve the registry alias
REGISTRY_ALIAS=$(aws ecr-public describe-registries --query 'registries[0].aliases[0].name' --output text)

if [ -z "$REGISTRY_ALIAS" ]; then
  echo "Failed to retrieve registry alias."
  exit 1
fi

# Construct the full repository URI
FULL_ECR_URI="public.ecr.aws/$REGISTRY_ALIAS"

# Function to check if repository exists
function check_repository_exists {
  echo "Checking if repository $REPOSITORY exists in ECR Public..."
  if ! aws ecr-public describe-repositories --repository-name "$REPOSITORY" > /dev/null 2>&1; then
    echo "Repository $REPOSITORY does not exist. Exiting."
    exit 1
  fi
}

# Function to get the latest tag from upstream
function get_latest_upstream_tag {
  echo "Fetching available tags from the upstream registry for $repo..." >&2

  # Fetch all tags and select the latest (semantic or numeric)
  latest_tag=$(regctl tag ls "$source/$owner/$repo" | grep -E "^[0-9]+(\.[0-9]+)*$" | sort --version-sort | tail -n 1)

  if [ -z "$latest_tag" ]; then
    echo "No valid tags found for $repo." >&2
    return 1
  fi

  echo "$latest_tag"
  return 0
}

# Function to pull an image or OCI artifact using regctl
function pull_artifact {
  echo "Pulling $type from $source with regctl..."
  regctl image copy "$source/$owner/$repo:$tag" "$FULL_ECR_URI/$REPOSITORY:$tag"
}

# Main script
CONFIG_FILE=".github/imageList.yml"
IMAGES=$(yq -r '.images[] | "\(.name)|\(.type)|\(.source)|\(.owner)|\(.repo)|\(.semantic)"' "$CONFIG_FILE")

echo "$IMAGES" | while IFS="|" read -r name type source owner repo semantic; do
  REPOSITORY="$name"
  echo "Repo name is = $REPOSITORY"

  # Get the list of tags
  tags_list=$(regctl tag ls "$FULL_ECR_URI/$REPOSITORY")
  echo "Tag list is = $tags_list"
  if [ -z "$tags_list" ]; then
    echo "No tags are available for $repo." >&2
    return 1
  else
    tags_list=
  fi

  # Determine the current tag (highest semantic or numeric)
  current_tag=$(echo "$tags_list" | grep -E "^[0-9]+(\.[0-9]+)*$" | sort --version-sort | tail -n 1)
  echo "Current tag is = $current_tag"

  # Check if the returned tag is purely numeric or semantic
  if [[ "$current_tag" =~ ^[0-9]+$ ]]; then
    echo "Current tag is numeric: $current_tag"
  else
    echo "Current tag is semantic: $current_tag"
  fi

  # Check if the repository exists in ECR Public
  echo "Check if the repository exists in ECR Public"
  check_repository_exists

  # Get the latest upstream tag
  echo "Get the latest upstream tag, function run get_latest_upstream_tag"
  tag=$(get_latest_upstream_tag)

  if [ "$tag" != "$current_tag" ]; then
    echo "New version found: $tag for $name"
    echo "Pull new version from upstream"
    pull_artifact
  else
    echo "No new version found for $name."
  fi

done
