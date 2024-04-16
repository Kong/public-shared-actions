# Security actions

## Action implemented

- [SCA](./action.yml) is a unified action for composition analysis. The action produces an SBOM, CVE reports for a given image / directory / file.
  - Tools used:
    - [syft](https://github.com/anchore/syft) generates a Software Bill of Materials (SBOM)
    - [grype](https://github.com/anchore/grype) vulnerability scanner for CVE analysis

### Scan

- Use [SCA](./action.yml) for directories and files
- Use [SCAN-DOCKER-IMAGE](../scan-docker-image/action.yml) for docker images

#### SBOM Generation Working

- Leverages the syft action to generate an SBOM based on input parameters and uploads it as a github workflow artifact

#### Vulnerability Scanning Working

- Action performs a scan of the sbom based on a user provided grype configuration:
  - First iteration:
    - runs and uploads artifacts in SARIF format and doesn't fail build
    - Additional grype ignore rules are **applied and supressed** in output artifact
    - Helps achieve better visualization using sarif
  - Second iteration:
    - runs and uploads artifacts in JSON format and doesn't fail build
    - Additional grype ignore rules and matches are **applied and displayed** in output artifact
    - Helps security team better perform deep analysis of scan and config
  - Third iteration runs:
    - Outputs table format in console log and fails build based on severity cutoff and input parameters
    - Additional grype ignore rules and matches are applied and suppressed in console log
    - Helps developers better prioritize cve's by suppressing false positives and bypass cve's during hot fixes using break glass strategy

#### Input specification

- Global parameters can be used for enforcement by centralized team across all repositories.

- These parameters are controlled in the [scan-metadata.sh](./scripts/scan-metadata.sh)

- User provided input parameters are exposed to the workflows consuming the shared action

- Global parameters are not exposed to the workflows consuming the shared action

- Global parameters take **precedence / override** any user provided input parameters

- Action assumes the container image to exist locally; otherwise uses credentials to pull from private registry

#### Global parameters

```yaml
  global_severity_cutoff:
    description: 'grype/trivy vulnerability severity cutoff'
    options:
    - 'negligible'
    - 'low'
    - 'medium'
    - 'high'
    - 'critical'
  global_enforce_build_failure:
    description: 'This will enforce the build failure regardless of `fail_build` external input parameter value for a specified `severity_cutoff`'
```

### Required Workflow Permissions

```yaml
permissions:
  contents: write # publish sbom to GH releases/tag assets
```

#### User provided input parameters

- Inputs **image / dir / file** are mutually exclusive. Any one input is mandatory

```yaml
  asset_prefix:
    description: 'prefix for generated scan artifacts'
    required: false
    default: ''
  dir: 
    description: 'Specify a directory to be scanned. This is mutually exclusive to file and image'
    required: 'false'
    default: ''
  file:
    description: 'Specify a file to be scanned. This is mutually exclusive to dir and image'
    required: 'false'
    default: ''
  config:
    description: 'file path to syft custom configuration'
    required: false
  fail_build:
    description: 'fail the build if the vulnerability is above the severity cutoff'
    required: 'false'
    default: 'false'
    type: choice
    options:
    - 'true'
    - 'false'
  github-token:
    description: "Authorized secret GitHub Personal Access Token. Defaults to github.token"
    required: false
    default: ${{ github.token }}
  upload-sbom-release-assets:
    description: 'specify to only upload sboms to GH release assets.'
    required: false
    default: false
    type: choice
    options:
    - 'true'
    - 'false'
```

#### Output specification

- Generates sbom reports in **spdx.json** and **cyclonedx.xml** formats using *syft* on the inputs **image / dir / file**

- Generates cve vulnerability analysis report based on the spdx sbom file using *grype*

- Uploads all the generated security assets as workflow artifacts and retained based on repo / org settings

- When `upload-sbom-release-assets` is enabled, publishes only the SBOMs to tags / GH release assets

#### Output parameters

```yaml
    grype-sarif-report:
      description: 'vulnerability SARIF report'
    grype-json-report:
      description: 'vulnerability JSON report'  
    sbom-spdx-report:
      description: 'SBOM spdx report'
    sbom-cyclonedx-report:
      description: 'SBOM cyclonedx report'
```

### Migration Strategy

1. The shared action is built to enforce using a global toggle managed by security team, but we don't block, regardless of severity i.e (No Enforcement Yet)

2. Teams integrate the shared action for visibility of the vulnerabilities in their SBOM (image / filesystem) but are not impacted

3. A deadline is set, at which point the scan will turn to block for certain severities e.g. only criticals i.e (Enforcement of build failures). This will be communicated extensively across Kong

4. Using visibility from step 2 / quick CVE scan results, teams can now work to remediate all critical findings. The expectation here is that almost all (almost all because a new rule might be integrated into the scanner just before we turn to block on) critical vulnerabilities would be remediated before we start blocking

5. On the deadline, we enforce global force failing of builds to be turned on. Except for a few outliers from step 3, there should be no impact

6. We repeat steps 2-5 by moving down in severity until all remaining vulnerabilities are within our risk appetite

### Break glass strategy

We expect application teams to use the advanced configuration of ignore rules with due diligence in case of hotfixes/emergency releases

To bypass blocking builds during emergency releases/scenarios where CVE fix needs a lot of refactoring during a hotfix:

#### Syft 

1. Generate a Syft [Override](https://github.com/anchore/syft?tab=readme-ov-file#configuration) configuration file
2. [Select catalogers](https://github.com/anchore/syft?tab=readme-ov-file#package-cataloger-selection)
3. [Excluding file paths (only in file system scans)](https://github.com/anchore/syft?tab=readme-ov-file#configuration)
4. Specify override [config input](https://github.com/Kong/public-shared-actions/blob/main/security-actions/scan-docker-image/action.yml#L23) to the shared action

#### Grype

1. Create a `.grype/config.yaml` [override](https://github.com/anchore/scan-action#additional-configuration) configuration file in the root of the repository
2. Customize Grype vulnerability results using [ignore rules](https://github.com/anchore/grype#specifying-matches-to-ignore)
3. These ignore rules take effect during the CVE scan that decides the build state (i.e blocking / non-blocking) for a provided global severity cutoff

#### Usage Examples

For scanning filesystem directories / paths:

```yml
name: SCA Repository Scan

on:
  pull_request:
    branches:
    - main
  push:
    branches:
    - main
    tags:
    - '*'

jobs:
  sca:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      issues: read
      checks: write
      pull-requests: write
    name: Repository Scan
    steps:
        - uses: actions/checkout@v4
        - name: Scan Repository
          id: sca_repo
          uses: Kong/public-shared-actions/security-actions/sca@main
          with:
            asset_prefix: <repo-name-slug> #output files prefix
            dir: '.' # Path to directory where the repository is checked out
            config: .syft.yaml # Custom config for overrides in repository root
            fail_build: 'true' # Fail job if critical vulnerabilities are detected
```