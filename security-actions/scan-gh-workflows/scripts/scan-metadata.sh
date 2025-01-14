#!/usr/bin/env bash

set -euo pipefail

readonly report_file_name="zizmor_gh_anti_pattern"
readonly json_ext="${report_file_name}.json"
readonly sarif_ext="${report_file_name}.sarif"
readonly out_ext="${report_file_name}.txt"

global_enforce_build_failure='false'

# Function to check if a given string matches the remote repo format
is_remote_repo() {
  # Regex to match the form owner/repo or owner/repo@sha
  # This allows owner and repo to contain alphanumeric characters, hyphens, and underscores.
  # sha is optional and must start with "@" followed by alphanumeric characters and/or hyphens
  [[ "$1" =~ ^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+(@[a-zA-Z0-9_-]+)?$ ]]
}

if [[ -n ${ASSET_PREFIX} ]]; then
    echo "report_file_name=${ASSET_PREFIX##*/}_${report_file_name}" >> "$GITHUB_OUTPUT"
    echo "json_file=${ASSET_PREFIX##*/}_${json_ext}" >> "$GITHUB_OUTPUT"
    echo "sarif_file=${ASSET_PREFIX##*/}_${sarif_ext}" >> "$GITHUB_OUTPUT"
    echo "out_file=${ASSET_PREFIX##*/}_${out_ext}" >> "$GITHUB_OUTPUT"
else
    echo "report_file_name=${report_file_name}" >> "$GITHUB_OUTPUT"
    echo "json_file=${json_ext}" >> "$GITHUB_OUTPUT"
    echo "sarif_file=${sarif_ext}" >> "$GITHUB_OUTPUT"
    echo "out_file=${out_ext}" >> "$GITHUB_OUTPUT"
fi

if [[ -n ${global_enforce_build_failure} ]]; then
    echo "global_enforce_build_failure=${global_enforce_build_failure}" >> "$GITHUB_OUTPUT"
fi

if [[ -z ${SCAN_PATH} ]]; then
    echo 'Specify "scan_path" input' >&2
    exit 1
fi

# Always scan for both GH workflows and GH composite actions within a scan path"
# Refer https://woodruffw.github.io/zizmor/usage/#input-collection
scan_args="--collect=all --persona=${PERSONA}"

# When GITHUB_TOKEN input is specified
if [[ -n ${GITHUB_TOKEN} ]]; then
    echo 'Found CI token for online checks'
    # Check if explicitly specified to run only offline audit checks    
    if [[ -n "${OFFLINE_AUDIT_CHECKS}" ]] && [[ "${OFFLINE_AUDIT_CHECKS}" == "true" ]]; then
        echo 'Explicitly requested for only offline audit checks'
        scan_args+=" --no-online-audits"
    fi
fi

# If scan_path matches local path:
if [[ -d ${SCAN_PATH} ]] || [[ -f ${SCAN_PATH} ]]; then
    echo "Input: ${SCAN_PATH}, exists locally"
    if [[ -z ${GITHUB_TOKEN} ]]; then
        echo 'CI token was not set. Continuing scan with only offline audit checks'
        scan_args+=" --no-online-audits"
    fi
# If scan_path matches remote repo format:
elif is_remote_repo "${SCAN_PATH}"; then
    echo "Input: ${SCAN_PATH}, matches remote repository of format: {owner}/{repo}[@<sha>]"
    # Check if GH_TOKEN is set for remote repo pulls
    if [[ -z ${GITHUB_TOKEN} ]]; then
        echo '::Input "github_token" must be set' >&2
        exit 1  
    fi  
else
    echo "Input: ${SCAN_PATH} is invalid. Must be one of directory / file / remote repository with github workflows" >&2
    exit 1
fi

echo "GH Actions sast scanning arguments: ${scan_args}"
echo "scan_args=${scan_args}" >> "$GITHUB_OUTPUT"