#!/usr/bin/env bash

set -euo pipefail

readonly signature_ext=".sig"
readonly signing_cert_ext=".crt"


signing_args="--yes --tlog-upload=${REKOR_TRANSPARENCY}"

if [[ ${MULTI_PLATFORM} ]]; then
    signing_args+=" --recursive"
fi

if [[ "${LOCAL_SAVE_COSIGN_ASSETS}" == "true" ]]; then
    if [[ -n "${ASSET_PREFIX}" ]]; then
        signature_file="${ASSET_PREFIX##*/}${signature_ext}"
        certificate_file="${ASSET_PREFIX##*/}${signing_cert_ext}"
    else
        echo '::error ::set input cosign_output_prefix in $0'
        exit 1
    #     signature_file="${ASSET_PREFIX##*/}${signature_ext}"
    #     certificate_file="${ASSET_PREFIX##*/}${signing_cert_ext}"
    fi

    echo "signature_file=${signature_file}" >> $GITHUB_OUTPUT
    echo "certificate_file=${certificate_file}" >> $GITHUB_OUTPUT
    signing_args+=" --output-certificate=${certificate_file} --output-signature=${signature_file}"
fi

echo "COSIGN SIGNING ARGS: ${signing_args}"
echo "cosign_signing_args=${signing_args}" >> $GITHUB_OUTPUT