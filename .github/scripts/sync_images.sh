#!/bin/bash

set -euo pipefail

ECR_URI="public.ecr.aws/k9g5m0d7/$1"

# Functions
function check_or_create_repository {
  echo "Checking if repository $REPOSITORY exists in ECR Public..."
  aws ecr-public describe-repositories --repository-name "$REPOSITORY" || \
  aws ecr-public create-repository --repository-name "$REPOSITORY"
}

function pull_docker_image {
  case "$source" in
    dockerhub)
      echo "Pulling Docker image from Docker Hub..."
      docker pull "$owner/$repo:$tag"
      ;;
    ghcr)
      echo "Pulling Docker image from GitHub Container Registry..."
      docker pull "ghcr.io/$owner/$repo:$tag"
      ;;
    *)
      echo "Unknown image source $source"
      ;;
  esac
}

function push_docker_image {
  echo "Tagging and pushing Docker image to ECR..."
  docker tag "$owner/$repo:$tag" "$ECR_URI/$REPOSITORY:$tag"
  docker push "$ECR_URI/$REPOSITORY:$tag"
}

function pull_oci_artifact {
  echo "Pulling OCI artifact with ORAS..."
  oras pull "$source/$owner/$repo:$tag" --output "$OUTPUT_DIR" -v
}

function push_oci_artifact {
  echo "Pushing OCI artifact to ECR using ORAS..."
  oras push "$ECR_URI/$REPOSITORY:$tag" \
    --config config.json:application/vnd.aquasec.trivy.config.v1+json \
    db.tar.gz:application/vnd.aquasec.trivy.db.layer.v1.tar+gzip -v
}

# Main script
CONFIG_FILE=".github/imageList.yml"
IMAGES=$(yq -r '.images[] | "\(.name)|\(.type)|\(.source)|\(.owner)|\(.repo)|\(.tag)"' "$CONFIG_FILE")

echo "$IMAGES" | while IFS="|" read -r name type source owner repo tag; do
  echo "Processing $name from $source with type $type"
  REPOSITORY="$name"

  # Variables accessible to functions:
  # name, type, source, owner, repo, tag, REPOSITORY

  check_or_create_repository

  case "$type" in
    image)
      pull_docker_image
      push_docker_image
      ;;
    oci)
      OUTPUT_DIR="ociImage_$name"
      mkdir -p "$OUTPUT_DIR"
      pull_oci_artifact
      cd "$OUTPUT_DIR"
      echo '{}' > config.json
      push_oci_artifact
      cd ..
      ;;
    *)
      echo "Unknown type $type"
      ;;
  esac
done
