#!/usr/bin/env bash

set -euo pipefail

readonly cve_json_ext="cve-report.json"
readonly cve_sarif_ext="cve-report.sarif"

global_severity_cutoff='critical'
global_enforce_build_failure='false'

if [[ -z ${DIR} ]]; then
    echo '::error ::Specify "dir"'
    exit 1
fi

if [[ -n ${DIR} ]]; then
    echo "scan_dir=${DIR}" >> $GITHUB_OUTPUT
fi

if [[ -n ${ASSET_PREFIX} ]]; then
    echo "grype_json_file=${ASSET_PREFIX##*/}-${cve_json_ext}" >> $GITHUB_OUTPUT
    echo "grype_sarif_file=${ASSET_PREFIX##*/}-${cve_sarif_ext}" >> $GITHUB_OUTPUT
else
    echo "grype_json_file=${cve_json_ext}" >> $GITHUB_OUTPUT
    echo "grype_sarif_file=${cve_sarif_ext}" >> $GITHUB_OUTPUT
fi

if [[ -n ${global_severity_cutoff} ]]; then
    echo "global_severity_cutoff=${global_severity_cutoff}" >> $GITHUB_OUTPUT
else
    echo '::error ::set global_severity_cutoff in $0'
    exit 1
fi

if [[ -n ${global_enforce_build_failure} ]]; then
    echo "global_enforce_build_failure=${global_enforce_build_failure}" >> $GITHUB_OUTPUT
else
    echo '::error ::set global_enforce_build_failure in $0'
    exit 1
fi
