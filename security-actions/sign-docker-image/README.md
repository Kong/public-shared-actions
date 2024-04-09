# Security actions

## Action implemented

- [Sign Docker Image](./sign-docker-image/action.yml) is a unified action for container image signing. The action leverages keyless signing to produce an Signature and uploads to Docker Image layer and Public Rekor for transaprency.

- Tools used:
    - [Cosign](https://github.com/sigstore/cosign)
### Signing Docker Image

- For workflows where image artifact are being pushed to the registry, this needs to be implemented `after the scan and before the publish` step.

#### Workflow / Job Permissions for Keyless OIDC Signing:
```yaml
permissions:
  packages: write
  id-token: write # needed for signing the images with GitHub OIDC Token
```

#### Signature Publishing
- `cosign sign` to:
  -  Generate an signature based on keyless identities using `Github` OIDC provider within workflows
- Be authenicated access to publish docker hub registry
- Uploads the [mapping identities](https://github.com/sigstore/fulcio/blob/main/docs/oid-info.md) to Public Rekor Instance logged forever.
  - **May Contain senstitive information for private repositories**; Yet no way to protect PII being uploaded / masked.

#### Verification
- `cosign verify` needs to have:
  - access to public rekor instance
  - authenicated access to private docker hub registry
  - un-authenticated access to public registry

#### Input specification

#### Parameters
```yaml
  local_save_cosign_assets:
    description: 'Save cosign output assets locally on disk. Ex: certificate and signature of signed artifacts'
    required: false
    default: false
  cosign-output-prefix:
    description: 'cosign output prefix. Ex: certificate and signature of signed artifacts'
    required: true
  signature_registry:
    description: 'Separate registry to store image signature to avoid polluting image registry'
    required: false
    default: ''
  tags:
    description: 'Comma separated <image>:<tag> that have same digest'
    required: true
  image_digest:
    description: 'specify single sha256 digest associated with the specified image_registries'
    required: true
  registry_username:
    description: 'docker username to login against private docker registry'
    required: false
  registry_password:
    description: 'docker password to login against private docker registry'
    required: false

```
#### Output specification

- Generates a signature that is pushed to registry for every single platform and manifest digest

- Generates a log entry in Public Rekor transaprency for every digest being signed with a unique docker repository

- No Build Time artifacts are generated

#### Verification:
Use `cosign verify` command to specify claims and image digest to be verified against the rekor transaparency log and signature / certificate subject identity in the Docker registry

Example:
```
COSIGN_REPOSITORY=kong/notary cosign verify -a repo="Kong/kong-ee" -a workflow="Package & Release" --certificate-oidc-issuer="https://token.actions.githubusercontent.com" --certificate-identity-regexp="https://github.com/Kong/kong-ee/.github/workflows/release.yml*" <image>:<tag>@sha256:<disgest> 
```

#### Usage Examples

```yaml
  jobs:
    sign-docker-image:

      permissions:
        contents: read
        packages: write # needed to upload to packages to registry
        id-token: write # needed for signing the images with GitHub OIDC Token

      if: ${{ github.event_name != 'pull_request' || github.event.pull_request.head.repo.full_name == github.repository }}
      name: Sign Docker Image
      runs-on: ubuntu-22.04
      env:
        PRERELEASE_IMAGE: kongcloud/security-test-repo-pub:ubuntu_23_10 # multi arch image input
      steps:

      - uses: actions/checkout@v3

      - name: Install regctl
        uses: regclient/actions/regctl-installer@main

      - name: Parse Image Manifest Digest
        id: image_manifest_metadata
        run: |
          manifest_list_exists="$(
            if regctl manifest get "${PRERELEASE_IMAGE}" --format raw-body --require-list -v panic &> /dev/null; then
              echo true
            else
              echo false
            fi
          )"
          echo "manifest_list_exists=$manifest_list_exists"
          echo "manifest_list_exists=$manifest_list_exists" >> $GITHUB_OUTPUT

          manifest_sha="$(regctl image digest "${PRERELEASE_IMAGE}")"

          echo "manifest_sha=$manifest_sha"
          echo "manifest_sha=$manifest_sha" >> $GITHUB_OUTPUT

      - name: Sign Image digest
        id: sign_image_pre_release
        if: steps.image_manifest_metadata.outputs.manifest_sha != ''
        uses: Kong/public-shared-actions/security-actions/sign-docker-image@main
        with:
          cosign_output_prefix: ubuntu-23-10
          signature_registry: kongcloud/security-test-repo-sig-pub # overrides repository to push image signatures; defaults to image repository
          tags: ${{ env.PRERELEASE_IMAGE }}
          image_digest: ${{ steps.image_manifest_metadata.outputs.manifest_sha }}
          local_save_cosign_assets: true
          registry_username: ${{ secrets.GHA_DOCKERHUB_PUSH_USER }}
          registry_password: ${{ secrets.GHA_KONG_ORG_DOCKERHUB_PUSH_TOKEN }}
```