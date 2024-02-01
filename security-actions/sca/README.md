# Security actions

## Action implemented

- [SCA](./sca/action.yml) is a unified action for composition analysis. The action produces an SBOM, CVE reports for a given image / directory / file.
  - Tools used:
    - [syft](https://github.com/anchore/syft) generates a Software Bill of Materials (SBOM)
    - [grype](https://github.com/anchore/grype) vulnerability scanner for CVE analysis

### Scan

- Use [SCA](./sca/action.yml) for directories and files
- Use [SCAN-DOCKER-IMAGE](./scan-docker-image/action.yml) for docker images

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

- These parameters are controlled in the [scan-metadata.sh](./security-actions/sca/scripts/scan-metadata.sh)

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
  image:
    description: 'specify an image to be scanned. Specify registry credentials if the image is remote. Takes priority over dir and file'
    required: 'false'
    default: ''
  tag:
    description: 'specify a docker image tag / release tag / ref to be scanned'
    required: 'false'
    default: ''
  registry_username:
    description: 'docker username to login against private docker registry'
    required: 'false'
  registry_password:
    description: 'docker password to login against private docker registry'
    required: 'false'
  fail_build:
    description: 'fail the build if the vulnerability is above the severity cutoff'
    required: 'false'
    default: 'false'
    type: choice
    options:
    - 'true'
    - 'false'
```

#### Output specification

- Generates sbom reports in **spdx.json** and **cyclonedx.xml** formats using *syft* on the inputs **image / dir / file**

- Generates cve vulnerability analysis report based on the spdx sbom file using *grype*

- Uploads the security assets as workflow artifacts and retained based on repo / org settings

- Allows for publishing github releases with security assets

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

#### Usage Examples

Refer [directory-scan](./github/workflows/dir-scan.yml) for scanning non-docker files / paths

Refer [docker-image-scan](./github/workflows/docker-image-scan.yml) for scanning docker images / docker tar
