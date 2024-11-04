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

# Function to fetch tags greater than the current tag in imageList
function get_upstream_tags {
  echo "Fetching available tags from the upstream registry for $repo..." >&2

  # Fetch all tags
  latest_version=$(regctl tag ls "$source/$owner/$repo" | grep -E "^[0-9]+(\.[0-9]+)*$" | sort --version-sort | tail -n 1)

  if [ -z "$latest_version" ]; then
    echo "No semantic version tags found for $repo." >&2

    # Check for non-semantic integer tags
    latest_fixed_tag=$(regctl tag ls "$source/$owner/$repo" | grep -E "^[0-9]+$" | sort -n | tail -n 1)

    if [ -z "$latest_fixed_tag" ]; then
      echo "No fixed tags found for $repo. Using current tag." >&2
      echo "$current_tag"
      return 0
    else
      echo "Latest fixed tag found: $latest_fixed_tag" >&2
      echo "$latest_fixed_tag"
      return 0
    fi
  fi

  echo "Latest semantic version found: $latest_version" >&2
  echo "$latest_version"
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

  # Check if the tags list is empty
  if [ -z "$tags_list" ]; then
    echo "No images found in $FULL_ECR_URI/$REPOSITORY. Skipping..."
    current_tag=""
  else
    # Extract the highest semantic or numeric version
    current_tag=$(echo "$tags_list" | grep -E "^[0-9]+(\.[0-9]+)*$" | sort --version-sort | tail -n 1)
    if [ -z "$current_tag" ]; then
      current_tag=$(echo "$tags_list" | grep -E "^[0-9]+$" | sort -n | tail -n 1)
    fi
    echo "Current tag is = $current_tag"
  fi

  echo "Processing $name from $source with type $type and current tag $current_tag"

  # Check if the repository exists in ECR Public
  check_repository_exists

  # Get the upstream tags greater than the current version
  tag=$(get_upstream_tags)

  if [ "$tag" != "$current_tag" ]; then
    echo "New version found: $tag for $name"
    pull_artifact
  else
    echo "No new version found for $name."
  fi
done
