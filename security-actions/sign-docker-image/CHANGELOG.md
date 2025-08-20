# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## [5.0.1](https://github.com/Kong/public-shared-actions/compare/sign-docker-image@5.0.0...sign-docker-image@5.0.1) (2025-08-20)


### ♻️ Chores

* **deps:** pin GitHub Actions to commit SHA ([#290](https://github.com/Kong/public-shared-actions/issues/290)) ([a5cfb79](https://github.com/Kong/public-shared-actions/commit/a5cfb7971a69f2de94e2c01b333e9368d7f0f29e))





# 5.0.0 (2025-08-04)


### ✨ Features

* **ci:** gha analyzer action for anti-patterns ([#214](https://github.com/Kong/public-shared-actions/issues/214)) ([fc095d4](https://github.com/Kong/public-shared-actions/commit/fc095d45e81a8107a5b710b4b6a67cf4b0cf6aa5))
* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))
* **ci:** use private ECR and dockerhub notary for ci signing and provenance ([#273](https://github.com/Kong/public-shared-actions/issues/273)) ([ec3f7e6](https://github.com/Kong/public-shared-actions/commit/ec3f7e6638900dfb56c6963b61659512fc6dbe54))
* **ci:** use unscoped package names for git release tags ([#277](https://github.com/Kong/public-shared-actions/issues/277)) ([ed27e0b](https://github.com/Kong/public-shared-actions/commit/ed27e0b1baa15f43ad10420444bdd4f2fc2b3dab))
* **release:** publish [skip ci] ([80442c2](https://github.com/Kong/public-shared-actions/commit/80442c24d193f2a116f9305723ac144a297a8c6a))
* **release:** publish [skip ci] ([a18abf7](https://github.com/Kong/public-shared-actions/commit/a18abf762d6e2444bcbfd20de70451ea1e3bc1b1))
* **release:** publish [skip ci] ([f2b77d6](https://github.com/Kong/public-shared-actions/commit/f2b77d6aa619dbe3bfcc1ac4f99af7d02614e90a))
* **release:** publish [skip ci] ([fbf0fcb](https://github.com/Kong/public-shared-actions/commit/fbf0fcb6762ab4080fd2813d2e3eec0564cbdbf0))
* **release:** publish [skip ci] ([11e80bb](https://github.com/Kong/public-shared-actions/commit/11e80bb231ae182696a52f7ec7b0b9fae53303bf))
* **sign-docker-image:** set issuer to github-action ([#206](https://github.com/Kong/public-shared-actions/issues/206)) ([8f62a1d](https://github.com/Kong/public-shared-actions/commit/8f62a1ddf8c9c57c80ca0968a0d49e07902c0020))


### Breaking changes

* **ci:** 'Release tags' now use 'unscoped' package names
Applications and Package managers using:
- Release Tag names will need update the package names to new format
- Pinned SHA are NOT affected

* feat(release): dry run

* fix(release): remove allow branch config used for dry run
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





## [4.1.2](https://github.com/Kong/public-shared-actions/compare/@security-actions/sign-docker-image@4.1.1...@security-actions/sign-docker-image@4.1.2) (2025-07-17)

**Note:** Version bump only for package @security-actions/sign-docker-image





## [4.1.1](https://github.com/Kong/public-shared-actions/compare/@security-actions/sign-docker-image@4.1.0...@security-actions/sign-docker-image@4.1.1) (2025-03-19)


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))





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
