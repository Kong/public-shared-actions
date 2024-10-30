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

# Function to check or create repository
function check_or_create_repository {
  echo "Checking if repository $REPOSITORY exists in ECR Public..."
  aws ecr-public describe-repositories --repository-name "$REPOSITORY" > /dev/null 2>&1 || \
  aws ecr-public create-repository --repository-name "$REPOSITORY"
}

# Function to fetch tags greater than the current tag in imageList
function get_upstream_tags {
  if [ "$semantic" = true ]; then
    echo "Fetching available tags from the upstream registry for $repo..."
    
    # Fetch all tags and filter out only semantic versions (e.g., 1.0.0, 2.3, etc.)
    latest_version=$(regctl tag ls "$source/$owner/$repo" | grep -E "^[0-9]+(\.[0-9]+)*$" | sort --version-sort | tail -n 1)

    if [ -z "$latest_version" ]; then
      echo "No semantic version tags found for $repo."
      return 1
    fi
    
    echo "Latest semantic version found: $latest_version"

    # Return the latest version tag
    return "$latest_version"
  else
    echo "Semantic versioning is not enabled, using current tag."
    return "$current_tag"
  fi
}

# Function to pull an image or OCI artifact using regctl
function pull_artifact {
  echo "Pulling $type from $source with regctl..."
  regctl image copy "$source/$owner/$repo:$tag" "$FULL_ECR_URI/$REPOSITORY:$tag"
}

# Main script
CONFIG_FILE=".github/imageList.yml"
IMAGES=$(yq -r '.images[] | "\(.name)|\(.type)|\(.source)|\(.owner)|\(.repo)|\(.tag)|\(.semantic)"' "$CONFIG_FILE")

echo "$IMAGES" | while IFS="|" read -r name type source owner repo current_tag semantic; do
  echo "Processing $name from $source with type $type and current tag $current_tag"
  REPOSITORY="$name"

  # Check or create the repository in ECR Public
  check_or_create_repository

  # Get the upstream tags greater than the current version
  tag=$(get_upstream_tags)

  if [ "$tag" != "$current_tag" ]; then
    echo "New version found: $tag for $name"

    pull_artifact

  else
    echo "No new version found for $name."
  fi
done
