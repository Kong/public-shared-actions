#/usr/bin/env bash

set -euo pipefail

spdx_ext="sbom.spdx.json"
cyclonedx_ext="sbom.cyclonedx.json"
cve_json_ext="cve-report.json"
cve_sarif_ext="cve-report.sarif"

global_severity_cutoff='critical'
global_enforce_build_failure='false'


if ([[ ${IMAGE} != '' ]] && [[ ${DIR} != '' ]]) || ([[ ${IMAGE} != '' ]] && [[ ${FILE} != '' ]]) || ([[ ${DIR} != '' ]] && [[ ${FILE} != '' ]]); then
    echo '::error ::Input fields "image", "dir" and "file" are mutually exlcusive'
    exit 1
fi

if [[ ${IMAGE} == '' ]] && [[ ${DIR} == '' ]] && [[ ${FILE} == '' ]]; then
    echo '::error ::Specify one of "image", "dir" and "file" inputs fields'
    exit 1
fi

# OCI archive should be passed as image instead of file
if [[ ${IMAGE} != '' ]] && [[ ${TAG} != '' ]]; then
    echo "scan_image=${IMAGE}:${TAG}" >> $GITHUB_OUTPUT
elif [[ ${IMAGE} != '' ]]; then
    echo "scan_image=${IMAGE}" >> $GITHUB_OUTPUT
fi

if [[ ${DIR} != '' ]]; then
    echo "scan_dir=${DIR}" >> $GITHUB_OUTPUT
fi

if [[ ${FILE} != '' ]]; then
    echo "scan_file=${FILE}" >> $GITHUB_OUTPUT
fi

if [[ ${ASSET_PREFIX} != '' ]]; then
    echo "sbom_spdx_file=${ASSET_PREFIX##*/}-${spdx_ext}" >> $GITHUB_OUTPUT
    echo "sbom_cyclonedx_file=${ASSET_PREFIX##*/}-${cyclonedx_ext}" >> $GITHUB_OUTPUT
    echo "grype_json_file=${ASSET_PREFIX##*/}-${cve_json_ext}" >> $GITHUB_OUTPUT
    echo "grype_sarif_file=${ASSET_PREFIX##*/}-${cve_sarif_ext}" >> $GITHUB_OUTPUT
else
    echo "sbom_spdx_file=${spdx_ext}" >> $GITHUB_OUTPUT
    echo "sbom_cyclonedx_file=${cyclonedx_ext}" >> $GITHUB_OUTPUT
    echo "grype_json_file=${cve_json_ext}" >> $GITHUB_OUTPUT
    echo "grype_sarif_file=${cve_sarif_ext}" >> $GITHUB_OUTPUT
fi

if [[ ${global_severity_cutoff} != '' ]]; then
    echo "global_severity_cutoff=${global_severity_cutoff}" >> $GITHUB_OUTPUT
else
    echo '::error ::set global_severity_cutoff in $0'
    exit 1
fi

if [[ ${global_enforce_build_failure} != '' ]]; then
    echo "global_enforce_build_failure=${global_enforce_build_failure}" >> $GITHUB_OUTPUT
else
    echo '::error ::set global_enforce_build_failure in $0'
    exit 1
fi
