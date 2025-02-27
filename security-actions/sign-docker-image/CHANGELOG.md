# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

# [4.1.0](https://github.com/Kong/public-shared-actions/compare/@security-actions/sign-docker-image@4.0.1...@security-actions/sign-docker-image@4.1.0) (2025-02-27)


### ✨ Features

* **ci:** gha analyzer action for anti-patterns ([#214](https://github.com/Kong/public-shared-actions/issues/214)) ([fc095d4](https://github.com/Kong/public-shared-actions/commit/fc095d45e81a8107a5b710b4b6a67cf4b0cf6aa5))





## [4.0.1](https://github.com/Kong/public-shared-actions/compare/@security-actions/sign-docker-image@4.0.0...@security-actions/sign-docker-image@4.0.1) (2025-01-13)


### ♻️ Chores

* **sign-docker-image:** set issuer to github-action ([#206](https://github.com/Kong/public-shared-actions/issues/206)) ([8f62a1d](https://github.com/Kong/public-shared-actions/commit/8f62a1ddf8c9c57c80ca0968a0d49e07902c0020))





# 4.0.0 (2025-01-03)


### ✨ Features

* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### Breaking changes

* **release:** - Each project within Public Shared Action is now treated as an independent package.
- Each package will have its own versioned release.
- Releases tag example "@security-actions/scan-docker-image@1.1.0".
- Markdown (.md) files will be ignored when determining changes for releases.



## 2.2.2 (2024-04-25)



# 2.2.0 (2024-04-16)


### ♻️ Chores

* **readme:** Add usage examples to security actions ([#106](https://github.com/Kong/public-shared-actions/issues/106)) ([d9e10a3](https://github.com/Kong/public-shared-actions/commit/d9e10a320e1fe023ac52e380d349b26bba67152b))



# 2.1.0 (2024-03-20)


### ⚙️ Continuous Integrations

* **deps:** bump cosign to v2.2.3 to avoid sigstore TUF invalid key issue ([#100](https://github.com/Kong/public-shared-actions/issues/100)) ([590c699](https://github.com/Kong/public-shared-actions/commit/590c699fe824010d7d563a33cc60500d847d3f9e))



# 1.15.0 (2024-01-22)


### ✨ Features

* **SLSA/SEC-973:** container image signing action ([#65](https://github.com/Kong/public-shared-actions/issues/65)) ([b7def0b](https://github.com/Kong/public-shared-actions/commit/b7def0b377d98a22f0184651d6d9c93617312d82))
