#!/usr/bin/env bash

set -euo pipefail

if [[ -n ${manifest_dir} ]]; then
    echo "manifest_path=${manifest_dir}/Cargo.toml" >> "$GITHUB_OUTPUT"
fi