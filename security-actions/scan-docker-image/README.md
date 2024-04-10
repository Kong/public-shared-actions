# Security actions

## Action implemented

- [Scan Docker Image](./scan-docker-image/action.yml) is a action for container SCA image scanning and CIS benchmarks. The action produces an SBOM, CVE, and CIS benchmark scanning and reports for a given image.
  - Tools used:
    - [syft](https://github.com/anchore/syft) generates a Software Bill of Materials (SBOM)
    - [grype](https://github.com/anchore/grype) vulnerability scanner for container images
    - [trivy](https://github.com/aquasecurity/trivy) compliance scanner for docker-cis 

### Scan Docker Image

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

- Inputs **image** is mandatory

- OCI tar balls / Docker archives (OCI compatible) are considered as input type  **Image**

```yaml
  asset_prefix:
    description: 'prefix for generated scan artifacts'
    required: false
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
```

#### Output specification

- Generates sbom reports in **spdx.json** and **cyclonedx.xml** formats using *syft* on the inputs **image**

- Generates cve vulnerability analysis report based on the spdx sbom file using *grype*

- Generates docker-cis analysis report using *trivy*

- Uploads the security assets as workflow artifacts and retained based on repo / org settings

- Allows for publishing github releases with security assets

#### Output parameters

```yaml
    cis-json-report:
      description: 'docker-cis json report'
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

```yml
name: SCA Docker Image Manifest

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
  sca-docker-image:
    if: ${{ github.event_name != 'pull_request' || github.event.pull_request.head.repo.full_name == github.repository }}
    name: Scan Docker Image
    runs-on: ubuntu-22.04
    env:
      IMAGE: kong/kong-gateway-dev:latest # multi arch image input
    steps:
    - uses: actions/checkout@v4

    - name: Install regctl
      uses: regclient/actions/regctl-installer@main

    - name: Login to DockerHub
      if: success()
      uses: docker/login-action@v3
      with:
        username: ${{ secrets.GHA_DOCKERHUB_PULL_USER }}
        password: ${{ secrets.GHA_KONG_ORG_DOCKERHUB_PUBLIC_TOKEN }}

    - name: Parse Architecture Specific Image Manifest Digests
      id: image_manifest_metadata
      run: |
        manifest_list_exists="$(
          if regctl manifest get "${IMAGE}" --format raw-body --require-list -v panic &> /dev/null; then
            echo true
          else
            echo false
          fi
        )"
        echo "manifest_list_exists=$manifest_list_exists"
        echo "manifest_list_exists=$manifest_list_exists" >> $GITHUB_OUTPUT

        amd64_sha="$(regctl image digest "${IMAGE}" --platform linux/amd64 || echo '')"
        arm64_sha="$(regctl image digest "${IMAGE}" --platform linux/arm64 || echo '')"
        echo "amd64_sha=$amd64_sha"
        echo "amd64_sha=$amd64_sha" >> $GITHUB_OUTPUT
        echo "arm64_sha=$arm64_sha"
        echo "arm64_sha=$arm64_sha" >> $GITHUB_OUTPUT

    - name: Scan AMD64 Image digest
      id: sbom_action_amd64
      if: steps.image_manifest_metadata.outputs.amd64_sha != ''
      uses: Kong/public-shared-actions/security-actions/scan-docker-image@main
      with:
        asset_prefix: kong-gateway-dev-linux-amd64
        image: ${{env.IMAGE}}@${{ steps.image_manifest_metadata.outputs.amd64_sha }}

    - name: Scan ARM64 Image digest
      if: steps.image_manifest_metadata.outputs.manifest_list_exists == 'true' && steps.image_manifest_metadata.outputs.arm64_sha != ''
      id: sbom_action_arm64
      uses: Kong/public-shared-actions/security-actions/scan-docker-image@main
      with:
        asset_prefix: kong-gateway-dev-linux-arm64
        image: ${{env.IMAGE}}@${{ steps.image_manifest_metadata.outputs.arm64_sha }}
```