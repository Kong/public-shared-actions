# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## [5.0.1](https://github.com/Kong/public-shared-actions/compare/sca@5.0.0...sca@5.0.1) (2025-08-20)


### ♻️ Chores

* **deps:** pin GitHub Actions to commit SHA ([#290](https://github.com/Kong/public-shared-actions/issues/290)) ([a5cfb79](https://github.com/Kong/public-shared-actions/commit/a5cfb7971a69f2de94e2c01b333e9368d7f0f29e))





# 5.0.0 (2025-08-04)


### ✨ Features

* **ci:** gha analyzer action for anti-patterns ([#214](https://github.com/Kong/public-shared-actions/issues/214)) ([fc095d4](https://github.com/Kong/public-shared-actions/commit/fc095d45e81a8107a5b710b4b6a67cf4b0cf6aa5))
* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### 🐛 Bug Fixes

* **ci:** remove file existence dependency ([#262](https://github.com/Kong/public-shared-actions/issues/262)) ([8e97a58](https://github.com/Kong/public-shared-actions/commit/8e97a58608feade65ebf1ba3b8af397247a1749c))
* **sca,scan-docker-image:** trigger release for grype install update ([#276](https://github.com/Kong/public-shared-actions/issues/276)) ([6328fe4](https://github.com/Kong/public-shared-actions/commit/6328fe4e5cc60bda2b060bf91d3d1895b2f6817c))


### ♻️ Chores

* **ci:** pin 3rd-party actions to specific commit hashes ([#210](https://github.com/Kong/public-shared-actions/issues/210)) ([d2a3cdb](https://github.com/Kong/public-shared-actions/commit/d2a3cdbb2aa62d29cbc05042c6148a9155761367))
* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))
* **ci:** use unscoped package names for git release tags ([#277](https://github.com/Kong/public-shared-actions/issues/277)) ([ed27e0b](https://github.com/Kong/public-shared-actions/commit/ed27e0b1baa15f43ad10420444bdd4f2fc2b3dab))
* **release:** publish [skip ci] ([e33f6f6](https://github.com/Kong/public-shared-actions/commit/e33f6f6d5ccdaa8af245f29896a51fada48c5d7e))
* **release:** publish [skip ci] ([80442c2](https://github.com/Kong/public-shared-actions/commit/80442c24d193f2a116f9305723ac144a297a8c6a))
* **release:** publish [skip ci] ([8223e61](https://github.com/Kong/public-shared-actions/commit/8223e61a288ed9d31f507476da0d51e4f421a6af))
* **release:** publish [skip ci] ([a18abf7](https://github.com/Kong/public-shared-actions/commit/a18abf762d6e2444bcbfd20de70451ea1e3bc1b1))
* **release:** publish [skip ci] ([f2b77d6](https://github.com/Kong/public-shared-actions/commit/f2b77d6aa619dbe3bfcc1ac4f99af7d02614e90a))
* **release:** publish [skip ci] ([a5b1cfa](https://github.com/Kong/public-shared-actions/commit/a5b1cfac7d55d8cf9390456a1e6799425e28840d))
* **release:** publish [skip ci] ([11e80bb](https://github.com/Kong/public-shared-actions/commit/11e80bb231ae182696a52f7ec7b0b9fae53303bf))


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



## 2.5.1 (2024-09-03)



# 2.5.0 (2024-08-27)



## 2.4.1 (2024-08-22)



# 2.4.0 (2024-08-16)



# 2.3.0 (2024-05-20)



## 2.2.1 (2024-04-17)



# 2.2.0 (2024-04-16)


### ♻️ Chores

* **readme:** Add usage examples to security actions ([#106](https://github.com/Kong/public-shared-actions/issues/106)) ([d9e10a3](https://github.com/Kong/public-shared-actions/commit/d9e10a320e1fe023ac52e380d349b26bba67152b))
* **readme:** Add vulnerability migration and breakglass strategy for SCA and CVE action ([#107](https://github.com/Kong/public-shared-actions/issues/107)) ([ad89a25](https://github.com/Kong/public-shared-actions/commit/ad89a255ff44a03377215b8bccbfdc17c8c7fb46))



## 2.0.3 (2024-03-04)


### ⚙️ Continuous Integrations

* **.github:** deprecate reuse of sca scan action in docker image scan ([#95](https://github.com/Kong/public-shared-actions/issues/95)) ([60c9b13](https://github.com/Kong/public-shared-actions/commit/60c9b136104671b7091b2306c599d80fec34ae3f))



## 2.0.2 (2024-02-12)


### ✨ Features

* Add optional "config" input to sca syft action ([#94](https://github.com/Kong/public-shared-actions/issues/94)) ([b0ef627](https://github.com/Kong/public-shared-actions/commit/b0ef627fa71528272d1daa9257b71dc90246cc46))


### ⚙️ Continuous Integrations

* **.github:** generalize sca scan for non docker artifacts ([#89](https://github.com/Kong/public-shared-actions/issues/89)) ([7f27a2b](https://github.com/Kong/public-shared-actions/commit/7f27a2becf7cfbda29125107f07b1482fabe3b77))





## [4.1.4](https://github.com/Kong/public-shared-actions/compare/@security-actions/sca@4.1.3...@security-actions/sca@4.1.4) (2025-07-28)


### 🐛 Bug Fixes

* **sca,scan-docker-image:** trigger release for grype install update ([#276](https://github.com/Kong/public-shared-actions/issues/276)) ([6328fe4](https://github.com/Kong/public-shared-actions/commit/6328fe4e5cc60bda2b060bf91d3d1895b2f6817c))





## [4.1.3](https://github.com/Kong/public-shared-actions/compare/@security-actions/sca@4.1.2...@security-actions/sca@4.1.3) (2025-07-17)

**Note:** Version bump only for package @security-actions/sca





## [4.1.2](https://github.com/Kong/public-shared-actions/compare/@security-actions/sca@4.1.1...@security-actions/sca@4.1.2) (2025-07-01)


### 🐛 Bug Fixes

* **ci:** remove file existence dependency ([#262](https://github.com/Kong/public-shared-actions/issues/262)) ([8e97a58](https://github.com/Kong/public-shared-actions/commit/8e97a58608feade65ebf1ba3b8af397247a1749c))





## [4.1.1](https://github.com/Kong/public-shared-actions/compare/@security-actions/sca@4.1.0...@security-actions/sca@4.1.1) (2025-03-19)


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))





# [4.1.0](https://github.com/Kong/public-shared-actions/compare/@security-actions/sca@4.0.1...@security-actions/sca@4.1.0) (2025-02-27)


### ✨ Features

* **ci:** gha analyzer action for anti-patterns ([#214](https://github.com/Kong/public-shared-actions/issues/214)) ([fc095d4](https://github.com/Kong/public-shared-actions/commit/fc095d45e81a8107a5b710b4b6a67cf4b0cf6aa5))





## [4.0.1](https://github.com/Kong/public-shared-actions/compare/@security-actions/sca@4.0.0...@security-actions/sca@4.0.1) (2025-01-16)


### ♻️ Chores

* **ci:** pin 3rd-party actions to specific commit hashes ([#210](https://github.com/Kong/public-shared-actions/issues/210)) ([d2a3cdb](https://github.com/Kong/public-shared-actions/commit/d2a3cdbb2aa62d29cbc05042c6148a9155761367))





# 4.0.0 (2025-01-03)


### ✨ Features

* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### Breaking changes

* **release:** - Each project within Public Shared Action is now treated as an independent package.
- Each package will have its own versioned release.
- Releases tag example "@security-actions/scan-docker-image@1.1.0".
- Markdown (.md) files will be ignored when determining changes for releases.



## 2.5.1 (2024-09-03)



# 2.5.0 (2024-08-27)



## 2.4.1 (2024-08-22)



# 2.4.0 (2024-08-16)



# 2.3.0 (2024-05-20)



## 2.2.1 (2024-04-17)



# 2.2.0 (2024-04-16)


### ♻️ Chores

* **readme:** Add usage examples to security actions ([#106](https://github.com/Kong/public-shared-actions/issues/106)) ([d9e10a3](https://github.com/Kong/public-shared-actions/commit/d9e10a320e1fe023ac52e380d349b26bba67152b))
* **readme:** Add vulnerability migration and breakglass strategy for SCA and CVE action ([#107](https://github.com/Kong/public-shared-actions/issues/107)) ([ad89a25](https://github.com/Kong/public-shared-actions/commit/ad89a255ff44a03377215b8bccbfdc17c8c7fb46))



## 2.0.3 (2024-03-04)


### ⚙️ Continuous Integrations

* **.github:** deprecate reuse of sca scan action in docker image scan ([#95](https://github.com/Kong/public-shared-actions/issues/95)) ([60c9b13](https://github.com/Kong/public-shared-actions/commit/60c9b136104671b7091b2306c599d80fec34ae3f))



## 2.0.2 (2024-02-12)


### ✨ Features

* Add optional "config" input to sca syft action ([#94](https://github.com/Kong/public-shared-actions/issues/94)) ([b0ef627](https://github.com/Kong/public-shared-actions/commit/b0ef627fa71528272d1daa9257b71dc90246cc46))


### ⚙️ Continuous Integrations

* **.github:** generalize sca scan for non docker artifacts ([#89](https://github.com/Kong/public-shared-actions/issues/89)) ([7f27a2b](https://github.com/Kong/public-shared-actions/commit/7f27a2becf7cfbda29125107f07b1482fabe3b77))
