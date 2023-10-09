#!/usr/bin/env bash

set -euo pipefail

readonly signature_ext=".sig"
readonly signing_cert_ext=".crt"

if [[ -n ${ASSET_PREFIX} ]]; then

    signature_file="${ASSET_PREFIX##*/}${signature_ext}"
    certificate_file="${ASSET_PREFIX##*/}${signing_cert_ext}"

    echo "signature_file=${signature_file}" >> $GITHUB_OUTPUT
    echo "certificate_file=${certificate_file}" >> $GITHUB_OUTPUT
else 
    echo '::error ::set input cosign_output_prefix in $0'
    exit 1
fi
