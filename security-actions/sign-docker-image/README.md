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
- Uploads the Artifact digest and Subject (Email / GH workflow) as part of the [HashedRekord](https://www.bastionzero.com/blog/bastionzeros-openpubkey-why-i-think-it-is-the-most-important-security-research-ive-done) to Public Rekor Instance logged forever.
  - **Contain senstitive information for private repositories**; Yet no way to protect PII being uploaded / masked.

#### Verification
- `cosign verify` needs to have:
  - access to public rekor instance
  - authenicated access to private docker hub registry
  - un-authenticated access to public registry
  - use `--insecure-ignore-tlog` to skip verifying against rekor if transparency is optional


#### Input specification
- Global parameters can be used for controlling the transparency of logging sensitive information to Rekor when signing images on private repositories.

- These parameters are controlled in the [cosign-metadata.sh](./security-actions/sign-docker-image/scripts/cosign-metadata.sh)

- User provided input parameters are exposed to the workflows consuming the shared action

- Global parameters are not exposed to the workflows consuming the shared action

- Global parameters take **precedence / override** any user provided input parameters

- Action assumes the container image to exist locally; otherwise uses credentials to pull from private registry

#### Parameters
```yaml
  cosign-output-prefix:
    description: 'cosign output prefix. Ex: certificate and signature of signed artifacts'
    required: true
  rekor-transparency:
    description: 'rekor during publishing / verification transaprency for private repositories'
    default: false
    required: false
  image:
    description: 'specify an image to be signed'
    required: true
  tag:
    description: 'specify a image tag to be signed'
    required: true
  multi-platform:
    description: 'Is the image multi arch'
    required: false
    default: false
  registry_username:
    description: 'docker username to login against private docker registry'
    required: false
  registry_password:
    description: 'docker password to login against private docker registry'
    required: false

```

#### User provided input parameters

- Inputs **image / dir / file** are mutually exclusive. Any one input is mandatory

- OCI tar balls / Docker archives (OCI compatible) are considered as input type  **Image**

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

- Generates docker-cis analysis report using *trivy*

- Uploads the security assets as workflow artifacts and retained based on repo / org settings

- Allows for publishing github releases with security assets

#### Output parameters

```yaml
    cis-json-report:
      description: 'docker-cis json report'
    grype-sarif-report:
      description: 'vulnerability SARIF report'
    sbom-spdx-report:
      description: 'SBOM spdx report'
    sbom-cyclonedx-report:
      description: 'SBOM cyclonedx report'
```

#### Usage Examples

- Using action to scan single platform docker image as a step within a job 

   ```yaml
  jobs:
    release:
      name: Release
      runs-on: ubuntu-latest
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_BOT_TOKEN }}
        DOCKER_BASE_IMAGE_NAME: org/repo
      outputs:
        grype-report: ${{ steps.sbom_action.outputs.grype-sarif-report }}
        sbom-spdx-report: ${{ steps.sbom_action.outputs.sbom-spdx-report }}
        sbom-cyclonedx-report: ${{ steps.sbom_action.outputs.sbom-cyclonedx-report }}
        buildx-tags: ${{ steps.meta.output.tags }}
      steps:
        - name: Checkout Source Code
          uses: actions/checkout@v3
          with:
            token: ${{ secrets.GITHUB_BOT_TOKEN }}
        - name: Set Semver Release Tag
          run: |
            ## Assuming release tag is associated with docker tag
            ## Can use any github action to output release / artifact TAG
            echo "RELEASE_TAG=X.Y.Z" >> $GITHUB_ENV
        - name: Log in to Dockerhub
          uses: docker/login-action@v2.1.0
          with:
            username: ${{ secrets.DOCKERHUB_USERNAME }}
            password: ${{ secrets.DOCKERHUB_PASSWORD }}
        - name: Set up Docker Buildx
          uses: docker/setup-buildx-action@v2.2.0
          with:
            install: true
        - name: Docker meta
          id: meta
          uses: docker/metadata-action@v4
          with:
            images: ${{ env.DOCKER_BASE_IMAGE_NAME }}
            tags: |
              type=raw,value=latest,enable={{is_default_branch}}
              type=raw,value=${{ env.RELEASE_TAG }}
            sep-tags: ','
        - name: Docker build
          id: docker_buildx
          uses: docker/build-push-action@v3.2.0
          with:
            context: .
            push: false
            load: true  # Supports only single platform images
            target: <target>
            tags: ${{ steps.meta.outputs.tags }}
        - name: Scan and Generate vulnerability report
          id: sbom_action
          uses: Kong/public-shared-actions/security-actions/scan-docker-image@main
          with:
            asset_prefix: ${{ env.DOCKER_BASE_IMAGE_NAME }}
            image: ${{ env.DOCKER_BASE_IMAGE_NAME }}:${{ env.RELEASE_TAG }}
        - name: Draft GH Release
          id: release-drafter
          uses: release-drafter/release-drafter@v5
          with:
            name: ${{ env.RELEASE_TAG }}
            tag: ${{ env.RELEASE_TAG }}
            version: ${{ env.RELEASE_TAG }}
            publish: true
            commitish: ${{ github.sha }}
        - uses: actions/download-artifact@v3
          with:
            path: ${{ github.workspace }}/sbom-artifacts
        - uses: AButler/upload-release-assets@v2.0
          with:
            files: '${{ github.workspace }}/sbom-artifacts/**/*.sarif;${{ github.workspace }}/sbom-artifacts/**/*.spdx.json;${{ github.workspace }}/sbom-artifacts/**/*.cyclonedx.xml'
            repo-token: ${{ secrets.GITHUB_BOT_TOKEN }}
            release-tag: ${{ env.RELEASE_TAG }}
        # Push to registry after successful scanning and release
        - name: Retag and Push to registry
          if: ${{ (!failure() && steps.release-drafter.outputs.id != '') }}
          env:
            BUILDX_TAGS: ${{ steps.meta.outputs.tags }}
          run: |
            set -x
            for image in ${BUILDX_TAGS//,/ }; do \
              # Optionally re-tag image \
              docker push $image; \
            done
  ```

- Using action to scan single platform docker image as a job within a workflow
  - Uses *actions/upload-artifact@v3* and *actions/download-artifact@v3* to share docker archives across jobs
  - On successful workflow completion, delete the Docker Archive workflow artifact at the end; otherwise retain for a 1 day at most
  - Better visualization using separate scan job in the pipeline

  ```yaml
    env:
      DOCKER_OCI_ARCHIVE: "docker-archive"
      DOCKER_BASE_IMAGE_NAME: org/repo
    jobs:
      docker-build:
        name: Docker build
        runs-on: ubuntu-latest
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_BOT_TOKEN }}
        outputs:
          buildx-tags: ${{ steps.meta.output.tags }}
          release-tag: ${{ steps.version.outputs.release-tag}}
        steps:
          - name: Checkout Source Code
            uses: actions/checkout@v3
            with:
              token: ${{ secrets.GITHUB_BOT_TOKEN }}
          - name: Set Semver Release Tag
            id: version
            run: |
              ## Assuming release tag is associated with docker tag
              ## Can use any github action to output release / artifact TAG
              echo "release-tag=X.Y.Z" >> $GITHUB_OUTPUT
          - name: Log in to Dockerhub
            uses: docker/login-action@v2.1.0
            with:
              username: ${{ secrets.DOCKERHUB_USERNAME }}
              password: ${{ secrets.DOCKERHUB_PASSWORD }}
          - name: Set up Docker Buildx
            uses: docker/setup-buildx-action@v2.2.0
            with:
              install: true
          - name: Docker meta
            id: meta
            uses: docker/metadata-action@v4
            with:
              images: ${{ env.DOCKER_BASE_IMAGE_NAME }}
              tags: |
                type=raw,value=latest,enable={{is_default_branch}}
                type=raw,value=${{ env.RELEASE_TAG }}
              sep-tags: ','
          - name: Docker build
            id: docker_buildx
            uses: docker/build-push-action@v3.2.0
            with:
              context: .
              push: false
              load: false 
              target: <target>
              tags: ${{ steps.meta.outputs.tags }}
              outputs: "type=docker,dest=${{ env.DOCKER_OCI_ARCHIVE }}.tar" # Supports only single platform images
          - name: Upload Docker OCI layout TAR Artifact
          uses: actions/upload-artifact@v3
          with:
            name: ${{ env.DOCKER_OCI_ARCHIVE }}
            path: ${{ env.DOCKER_OCI_ARCHIVE }}.tar
            if-no-files-found: fail
            retention-days: 1

        scan:
          name: scan
          runs-on: ubuntu-latest
          needs: [docker-build]
          env:
            GITHUB_TOKEN: ${{ secrets.GITHUB_BOT_TOKEN }}
          outputs:
            grype-report: ${{ steps.sbom_action.outputs.grype-sarif-report }}
            sbom-spdx-report: ${{ steps.sbom_action.outputs.sbom-spdx-report }}
            sbom-cyclonedx-report: ${{ steps.sbom_action.outputs.sbom-cyclonedx-report }}
            buildx-tags: ${{ needs.docker-build.outputs.buildx-tags }}
          steps:
            - name: Download OCI docker TAR artifact
              uses: actions/download-artifact@v3
              with:
                name: ${{ env.DOCKER_OCI_ARCHIVE }}
                path: ${{ github.workspace }}/${{ env.DOCKER_OCI_ARCHIVE }}
            - name: Scan and Generate vulnerability report
              id: sbom_action
              uses: Kong/public-shared-actions/security-actions/scan-docker-image@main
              with:
                asset_prefix: ${{ env.DOCKER_BASE_IMAGE_NAME }}
                image: ${{github.workspace}}/${{ env.DOCKER_OCI_ARCHIVE }}/${{ env.DOCKER_OCI_ARCHIVE }}.tar
          
          release:
            name: release
            runs-on: ubuntu-latest
            needs: [scan, docker-build]
            env:
              GITHUB_TOKEN: ${{ secrets.GITHUB_BOT_TOKEN }}
              RELEASE_TAG:  ${{ needs.docker-build.outputs.release-tag }}
              BUILDX_TAGS: ${{ needs.scan.outputs.buildx-tags }}
            steps:
              - name: Draft GH Release
                id: release-drafter
                uses: release-drafter/release-drafter@v5
                with:
                  name: ${{ env.RELEASE_TAG }}
                  tag: ${{ env.RELEASE_TAG }}
                  version: ${{ env.RELEASE_TAG }}
                  publish: true
                  commitish: ${{ github.sha }}
              - uses: actions/download-artifact@v3
                with:
                  path: ${{ github.workspace }}/sbom-artifacts
              - run: |
                  ls -alR ${{ github.workspace }}/sbom-artifacts
              - uses: AButler/upload-release-assets@v2.0
                with:
                  files: '${{ github.workspace }}/sbom-artifacts/**/*.sarif;${{ github.workspace }}/sbom-artifacts/**/*.spdx.json;${{ github.workspace }}/sbom-artifacts/**/*.cyclonedx.xml'
                  repo-token: ${{ secrets.GITHUB_BOT_TOKEN }}
                  release-tag: ${{ env.RELEASE_TAG }}
              - name: Log in to Dockerhub
                uses: docker/login-action@v2.1.0
                with:
                  username: ${{ secrets.DOCKERHUB_USERNAME }}
                  password: ${{ secrets.DOCKERHUB_PASSWORD }}
              
              # Load the archive as image into docker daemon
              - name: Load and Inspect docker archive 
                run: |
                  docker load --input ${{ github.workspace }}/${{ env.DOCKER_OCI_ARCHIVE }}/${{ env.DOCKER_OCI_ARCHIVE }}.tar
                  docker image ls

              # Push to registry after successful scanning and release
              - name: Retag and Push to registry
                if: ${{ (!failure() && steps.release-drafter.outputs.id != '') }}
                run: |
                  set -x
                  for image in ${BUILDX_TAGS//,/ }; do \
                    # Optionally re-tag image \
                    docker push $image; \
                  done

          cleanup-artifacts:
            name: Cleanup
            needs:
              - release
            if: always()
            runs-on: ubuntu-latest
            env:
              GITHUB_TOKEN: ${{ secrets.GITHUB_BOT_TOKEN }}
            steps:
              - uses: geekyeggo/delete-artifact@v2
                with: 
                  failOnError: false
                  name: |
                    ${{ env.DOCKER_OCI_ARCHIVE }}
  ```

- Using action to scan multiple platform docker image as a step within a job
  - Use matrix strategy to build and load each image archive independently

  ```yaml
  jobs:
    metadata:
      name: Set release metadata
      runs-on: ubuntu-latest
      outputs:
        RELEASE_TAG: ${{ steps.release_meta.output.release_tag }}
      steps:
        - name: Set Semver Release Tag
          id: release_meta
          run: |
            ## Assuming release tag is associated with docker tag
            ## Can use any github action to output release / artifact TAG
            echo "release_tag=X.Y.Z" >> $GITHUB_OUTPUT

    release:
        name: Build, Scan & Release
        runs-on: ubuntu-latest
        strategy:
          matrix:
            architecture: [aarch64, x86_64]
            ostype: [linux-gnu, linux-musl]
        needs: [metadata]
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_BOT_TOKEN }}
          DOCKER_BASE_IMAGE_NAME: org/repo
          RELEASE_TAG: ${{ steps.metadata.outputs.RELEASE_TAG }}
        outputs:
          grype-report: ${{ steps.sbom_action.outputs.grype-sarif-report }}
          sbom-spdx-report: ${{ steps.sbom_action.outputs.sbom-spdx-report }}
          sbom-cyclonedx-report: ${{ steps.sbom_action.outputs.sbom-cyclonedx-report }}
          buildx-tags: ${{ steps.meta.output.tags }}
        steps:
          - name: Checkout Source Code
            uses: actions/checkout@v3
            with:
              token: ${{ secrets.GITHUB_BOT_TOKEN }}
          - name: Log in to Dockerhub
            uses: docker/login-action@v2.1.0
            with:
              username: ${{ secrets.DOCKERHUB_USERNAME }}
              password: ${{ secrets.DOCKERHUB_PASSWORD }}
          - name: Set environment variables
            run: |
              grep -v '^#' .env >> $GITHUB_ENV
              echo "ARCHITECTURE=${{ matrix.architecture }}" >> $GITHUB_ENV
              echo "OSTYPE=${{ matrix.ostype }}" >> $GITHUB_ENV
          - uses: docker/setup-qemu-action@v2
          - name: Set up Docker Buildx
            uses: docker/setup-buildx-action@v2.2.0
            with:
              install: true
          - name: Docker meta
            id: meta
            uses: docker/metadata-action@v4
            with:
              images: ${{ env.DOCKER_BASE_IMAGE_NAME }}
              flavor: |
              suffix=-${{ matrix.architecture }}-${{ matrix.ostype }}
              tags: |
                type=raw,value=${{ env.RELEASE_TAG }}
              sep-tags: ','
          - name: Docker build
            id: docker_buildx
            uses: docker/build-push-action@v3.2.0
            with:
              context: .
              push: false
              load: true  # Supports only single platform images
              target: <target>
              tags: ${{ steps.meta.outputs.tags }}
          - name: Scan and Generate vulnerability report
            id: sbom_action
            uses: Kong/public-shared-actions/security-actions/scan-docker-image@main
            with:
              asset_prefix: ${{ env.DOCKER_BASE_IMAGE_NAME }}
              image: ${{ env.DOCKER_BASE_IMAGE_NAME }}:${{ env.RELEASE_TAG }}
          - name: Draft GH Release
            id: release-drafter
            uses: release-drafter/release-drafter@v5
            with:
              name: ${{ env.RELEASE_TAG }}
              tag: ${{ env.RELEASE_TAG }}
              version: ${{ env.RELEASE_TAG }}
              publish: true
              commitish: ${{ github.sha }}
          - uses: actions/download-artifact@v3
            with:
              path: ${{ github.workspace }}/sbom-artifacts
          - run: |
              ls -alR ${{ github.workspace }}/sbom-artifacts
          - uses: AButler/upload-release-assets@v2.0
            with:
              files: '${{ github.workspace }}/sbom-artifacts/**/*.sarif;${{ github.workspace }}/sbom-artifacts/**/*.spdx.json;${{ github.workspace }}/sbom-artifacts/**/*.cyclonedx.xml'
              repo-token: ${{ secrets.GITHUB_BOT_TOKEN }}
              release-tag: ${{ env.RELEASE_TAG }}
          # Push to registry after successful scanning and release
          - name: Retag and Push to registry
            if: ${{ (!failure() && steps.release-drafter.outputs.id != '') }}
            env:
              BUILDX_TAGS: ${{ steps.meta.outputs.tags }}
            run: |
              set -x
              for image in ${BUILDX_TAGS//,/ }; do \
                # Optionally re-tag image \
                docker push $image; \
              done
    ```