# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

# [6.0.0](https://github.com/Kong/public-shared-actions/compare/scan-docker-image@5.1.1...scan-docker-image@6.0.0) (2025-09-26)


### ✨ Features

* **sca:** refactored grype cache ([#318](https://github.com/Kong/public-shared-actions/issues/318)) ([76168bc](https://github.com/Kong/public-shared-actions/commit/76168bc4c2baf05cf029dbd65d3c05973512b17f))


### Breaking changes

* **sca:** - Removes "force_grype_db_update" and "skip_grype_db_cache" input
- Adds "grype_db_cache" and "grype_db_cache_token" input for private grype db mirror
- Grype DB caching strategy: GH Cache -> Grype DB mirror (if specified) -> Grype upstream





## [5.1.1](https://github.com/Kong/public-shared-actions/compare/scan-docker-image@5.1.0...scan-docker-image@5.1.1) (2025-09-21)


### ♻️ Chores

* **deps:** combine update dep versions ([#312](https://github.com/Kong/public-shared-actions/issues/312)) ([be84213](https://github.com/Kong/public-shared-actions/commit/be84213f82c250fcd4b6d89d6a26e08da4b32184))





# [5.1.0](https://github.com/Kong/public-shared-actions/compare/scan-docker-image@5.0.2...scan-docker-image@5.1.0) (2025-09-17)


### ✨ Features

* **scan-docker-image:** add by-cve flag to organise results by CVE ([#310](https://github.com/Kong/public-shared-actions/issues/310)) ([43a61ce](https://github.com/Kong/public-shared-actions/commit/43a61cef051b763a26057da4085e7f5e6adcad9d))





## [5.0.2](https://github.com/Kong/public-shared-actions/compare/scan-docker-image@5.0.1...scan-docker-image@5.0.2) (2025-09-09)


### ♻️ Chores

* **deps:** update PSA deps ([#296](https://github.com/Kong/public-shared-actions/issues/296)) ([72f8cd3](https://github.com/Kong/public-shared-actions/commit/72f8cd345ddaf10734bf8d4d4f6139892c1a4360))





## [5.0.1](https://github.com/Kong/public-shared-actions/compare/scan-docker-image@5.0.0...scan-docker-image@5.0.1) (2025-08-20)


### ♻️ Chores

* **deps:** pin GitHub Actions to commit SHA ([#290](https://github.com/Kong/public-shared-actions/issues/290)) ([a5cfb79](https://github.com/Kong/public-shared-actions/commit/a5cfb7971a69f2de94e2c01b333e9368d7f0f29e))





# 5.0.0 (2025-08-04)


### ✨ Features

* **ci:** gha analyzer action for anti-patterns ([#214](https://github.com/Kong/public-shared-actions/issues/214)) ([fc095d4](https://github.com/Kong/public-shared-actions/commit/fc095d45e81a8107a5b710b4b6a67cf4b0cf6aa5))
* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))
* **scan-docker-image:** update grype version to v6.2.0 ([#255](https://github.com/Kong/public-shared-actions/issues/255)) ([b2dcb5b](https://github.com/Kong/public-shared-actions/commit/b2dcb5bffa26707224e00c7ba9759b2082bc3742))


### 🐛 Bug Fixes

* **ci:** remove file existence dependency ([#262](https://github.com/Kong/public-shared-actions/issues/262)) ([8e97a58](https://github.com/Kong/public-shared-actions/commit/8e97a58608feade65ebf1ba3b8af397247a1749c))
* **ci:** use embedded compliance checks across trivy runs when cache input is specified ([#239](https://github.com/Kong/public-shared-actions/issues/239)) ([7ab471c](https://github.com/Kong/public-shared-actions/commit/7ab471c4eb15591efde88c5ced2a1ba8c8b3b803))
* **sca,scan-docker-image:** trigger release for grype install update ([#276](https://github.com/Kong/public-shared-actions/issues/276)) ([6328fe4](https://github.com/Kong/public-shared-actions/commit/6328fe4e5cc60bda2b060bf91d3d1895b2f6817c))
* **scan-docker-image:** disable trivy exit-code for docker-cis ([#228](https://github.com/Kong/public-shared-actions/issues/228)) ([9f086e1](https://github.com/Kong/public-shared-actions/commit/9f086e1de6a02db2b1c9ab937d0f045d560c7742))
* **scan-docker-image:** grype outputs ([#241](https://github.com/Kong/public-shared-actions/issues/241)) ([971ba65](https://github.com/Kong/public-shared-actions/commit/971ba6548dc1fd1d9a60dd9527f6596905efff12))


### ♻️ Chores

* **ci:** bump trivy from v0.57.1 to v0.58.2 ([#225](https://github.com/Kong/public-shared-actions/issues/225)) ([7091a73](https://github.com/Kong/public-shared-actions/commit/7091a73d67a08634ec150129ab3d66f3f0244a21))
* **ci:** pin 3rd-party actions to specific commit hashes ([#210](https://github.com/Kong/public-shared-actions/issues/210)) ([d2a3cdb](https://github.com/Kong/public-shared-actions/commit/d2a3cdbb2aa62d29cbc05042c6148a9155761367))
* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))
* **ci:** use unscoped package names for git release tags ([#277](https://github.com/Kong/public-shared-actions/issues/277)) ([ed27e0b](https://github.com/Kong/public-shared-actions/commit/ed27e0b1baa15f43ad10420444bdd4f2fc2b3dab))
* **release:** publish [skip ci] ([e33f6f6](https://github.com/Kong/public-shared-actions/commit/e33f6f6d5ccdaa8af245f29896a51fada48c5d7e))
* **release:** publish [skip ci] ([b5b91fe](https://github.com/Kong/public-shared-actions/commit/b5b91fe7aca381f8d31a30c1916151e7eaa7f16a))
* **release:** publish [skip ci] ([68aebd2](https://github.com/Kong/public-shared-actions/commit/68aebd28ac4d8db2e31235fe313944592bf54ec6))
* **release:** publish [skip ci] ([8223e61](https://github.com/Kong/public-shared-actions/commit/8223e61a288ed9d31f507476da0d51e4f421a6af))
* **release:** publish [skip ci] ([1b7327a](https://github.com/Kong/public-shared-actions/commit/1b7327afc8857748a4d0638262b4d9697ac996b6))
* **release:** publish [skip ci] ([b78573f](https://github.com/Kong/public-shared-actions/commit/b78573f2af8072c7b396620f199ea129ac703bb7))
* **release:** publish [skip ci] ([fa3d956](https://github.com/Kong/public-shared-actions/commit/fa3d956324c2633b23cc3825b3403d91460675a1))
* **release:** publish [skip ci] ([a18abf7](https://github.com/Kong/public-shared-actions/commit/a18abf762d6e2444bcbfd20de70451ea1e3bc1b1))
* **release:** publish [skip ci] ([ac8939f](https://github.com/Kong/public-shared-actions/commit/ac8939f0382827fbb43ce4e0028066a5ea4db01d))
* **release:** publish [skip ci] ([98be9d7](https://github.com/Kong/public-shared-actions/commit/98be9d7dc50dd3823a7d1e7444ec54426293ab50))
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



# 2.8.0 (2024-12-02)


### ✨ Features

* **security-actions/scan-docker-image:** support `trivy_db_cache` as alternate ([#184](https://github.com/Kong/public-shared-actions/issues/184)) ([0ccacff](https://github.com/Kong/public-shared-actions/commit/0ccacffed804d85da3f938a1b78c12831935f992))



# 2.6.0 (2024-09-19)


### ✨ Features

* input to skip Trivy scan  ([#156](https://github.com/Kong/public-shared-actions/issues/156)) ([ecbcd70](https://github.com/Kong/public-shared-actions/commit/ecbcd7051e12e6e3dc37dc890820bbce457bc05f))



## 2.5.1 (2024-09-03)



# 2.5.0 (2024-08-27)


### 🐛 Bug Fixes

* omitted severity flags in docker image scan action ([#142](https://github.com/Kong/public-shared-actions/issues/142)) ([f19e9a7](https://github.com/Kong/public-shared-actions/commit/f19e9a7b75f547a5908e658627650a2175340dca))



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



## 2.0.1 (2024-02-07)


### ⚙️ Continuous Integrations

* **.github:** fix sca action path and ref for image scan ([#93](https://github.com/Kong/public-shared-actions/issues/93)) ([17456e7](https://github.com/Kong/public-shared-actions/commit/17456e74cf062b1d29d751331d8e2f5ac5baedd4))



# 2.0.0 (2024-02-01)


### ⚙️ Continuous Integrations

* **.github:** generalize sca scan for non docker artifacts ([#89](https://github.com/Kong/public-shared-actions/issues/89)) ([7f27a2b](https://github.com/Kong/public-shared-actions/commit/7f27a2becf7cfbda29125107f07b1482fabe3b77))



# 1.15.0 (2024-01-22)



# 1.13.0 (2023-09-18)



# 1.11.0 (2023-07-06)


### ✨ Features

* ingore unfixed for trivy image scan ([#51](https://github.com/Kong/public-shared-actions/issues/51)) ([1c1db81](https://github.com/Kong/public-shared-actions/commit/1c1db81d4bc99d8c87058fba34203419a0fd0604))


### 🐛 Bug Fixes

* **ci:** Fix grype output file and dependency ([#38](https://github.com/Kong/public-shared-actions/issues/38)) ([45d3c9a](https://github.com/Kong/public-shared-actions/commit/45d3c9a9e2e8ea822429c745f9cd755e38879752))



# 1.3.0 (2023-06-08)


### ✨ Features

* **cd:** add trivy docker-cis scan ([#1](https://github.com/Kong/public-shared-actions/issues/1)) ([84f743c](https://github.com/Kong/public-shared-actions/commit/84f743cf7cfdf5e75dc81e5c158c7e3d6181ced4))
* **cd:** Use pinned tags instead of latest  ([4b6870c](https://github.com/Kong/public-shared-actions/commit/4b6870cbdd4a0c8b78d77e9a210de7fa9eecc18d))


### 🐛 Bug Fixes

* **cd:** only pass input flag to trivy action when docker tar is present ([cbe4f65](https://github.com/Kong/public-shared-actions/commit/cbe4f65b04769cf67756f52984fc8508207d5f64))


### ♻️ Chores

* **docs:** update readme to include trivy docker-cis ([ab12bb2](https://github.com/Kong/public-shared-actions/commit/ab12bb2e88ed367ab47d1110f698cbfa3c68c0c5))
* **sbom-action:** bump sbom action to 0.13.4 ([396a2e4](https://github.com/Kong/public-shared-actions/commit/396a2e4e87b05d84df19455395a64b5aa2a967a5))





## [4.2.4](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.2.3...@security-actions/scan-docker-image@4.2.4) (2025-07-28)


### 🐛 Bug Fixes

* **sca,scan-docker-image:** trigger release for grype install update ([#276](https://github.com/Kong/public-shared-actions/issues/276)) ([6328fe4](https://github.com/Kong/public-shared-actions/commit/6328fe4e5cc60bda2b060bf91d3d1895b2f6817c))





## [4.2.3](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.2.2...@security-actions/scan-docker-image@4.2.3) (2025-07-17)

**Note:** Version bump only for package @security-actions/scan-docker-image





## [4.2.2](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.2.1...@security-actions/scan-docker-image@4.2.2) (2025-07-17)

**Note:** Version bump only for package @security-actions/scan-docker-image





## [4.2.1](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.2.0...@security-actions/scan-docker-image@4.2.1) (2025-07-01)


### 🐛 Bug Fixes

* **ci:** remove file existence dependency ([#262](https://github.com/Kong/public-shared-actions/issues/262)) ([8e97a58](https://github.com/Kong/public-shared-actions/commit/8e97a58608feade65ebf1ba3b8af397247a1749c))





# [4.2.0](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.1.5...@security-actions/scan-docker-image@4.2.0) (2025-05-21)


### ✨ Features

* **scan-docker-image:** update grype version to v6.2.0 ([#255](https://github.com/Kong/public-shared-actions/issues/255)) ([b2dcb5b](https://github.com/Kong/public-shared-actions/commit/b2dcb5bffa26707224e00c7ba9759b2082bc3742))





## [4.1.5](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.1.4...@security-actions/scan-docker-image@4.1.5) (2025-04-05)


### 🐛 Bug Fixes

* **scan-docker-image:** grype outputs ([#241](https://github.com/Kong/public-shared-actions/issues/241)) ([971ba65](https://github.com/Kong/public-shared-actions/commit/971ba6548dc1fd1d9a60dd9527f6596905efff12))





## [4.1.4](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.1.3...@security-actions/scan-docker-image@4.1.4) (2025-03-28)


### 🐛 Bug Fixes

* **ci:** use embedded compliance checks across trivy runs when cache input is specified ([#239](https://github.com/Kong/public-shared-actions/issues/239)) ([7ab471c](https://github.com/Kong/public-shared-actions/commit/7ab471c4eb15591efde88c5ced2a1ba8c8b3b803))





## [4.1.3](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.1.2...@security-actions/scan-docker-image@4.1.3) (2025-03-19)


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))





## [4.1.2](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.1.1...@security-actions/scan-docker-image@4.1.2) (2025-03-14)


### 🐛 Bug Fixes

* **scan-docker-image:** disable trivy exit-code for docker-cis ([#228](https://github.com/Kong/public-shared-actions/issues/228)) ([9f086e1](https://github.com/Kong/public-shared-actions/commit/9f086e1de6a02db2b1c9ab937d0f045d560c7742))





## [4.1.1](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.1.0...@security-actions/scan-docker-image@4.1.1) (2025-03-05)


### ♻️ Chores

* **ci:** bump trivy from v0.57.1 to v0.58.2 ([#225](https://github.com/Kong/public-shared-actions/issues/225)) ([7091a73](https://github.com/Kong/public-shared-actions/commit/7091a73d67a08634ec150129ab3d66f3f0244a21))





# [4.1.0](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.0.1...@security-actions/scan-docker-image@4.1.0) (2025-02-27)


### ✨ Features

* **ci:** gha analyzer action for anti-patterns ([#214](https://github.com/Kong/public-shared-actions/issues/214)) ([fc095d4](https://github.com/Kong/public-shared-actions/commit/fc095d45e81a8107a5b710b4b6a67cf4b0cf6aa5))





## [4.0.1](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-docker-image@4.0.0...@security-actions/scan-docker-image@4.0.1) (2025-01-16)


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



# 2.8.0 (2024-12-02)


### ✨ Features

* **security-actions/scan-docker-image:** support `trivy_db_cache` as alternate ([#184](https://github.com/Kong/public-shared-actions/issues/184)) ([0ccacff](https://github.com/Kong/public-shared-actions/commit/0ccacffed804d85da3f938a1b78c12831935f992))



# 2.6.0 (2024-09-19)


### ✨ Features

* input to skip Trivy scan  ([#156](https://github.com/Kong/public-shared-actions/issues/156)) ([ecbcd70](https://github.com/Kong/public-shared-actions/commit/ecbcd7051e12e6e3dc37dc890820bbce457bc05f))



## 2.5.1 (2024-09-03)



# 2.5.0 (2024-08-27)


### 🐛 Bug Fixes

* omitted severity flags in docker image scan action ([#142](https://github.com/Kong/public-shared-actions/issues/142)) ([f19e9a7](https://github.com/Kong/public-shared-actions/commit/f19e9a7b75f547a5908e658627650a2175340dca))



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



## 2.0.1 (2024-02-07)


### ⚙️ Continuous Integrations

* **.github:** fix sca action path and ref for image scan ([#93](https://github.com/Kong/public-shared-actions/issues/93)) ([17456e7](https://github.com/Kong/public-shared-actions/commit/17456e74cf062b1d29d751331d8e2f5ac5baedd4))



# 2.0.0 (2024-02-01)


### ⚙️ Continuous Integrations

* **.github:** generalize sca scan for non docker artifacts ([#89](https://github.com/Kong/public-shared-actions/issues/89)) ([7f27a2b](https://github.com/Kong/public-shared-actions/commit/7f27a2becf7cfbda29125107f07b1482fabe3b77))



# 1.15.0 (2024-01-22)



# 1.13.0 (2023-09-18)



# 1.11.0 (2023-07-06)


### ✨ Features

* ingore unfixed for trivy image scan ([#51](https://github.com/Kong/public-shared-actions/issues/51)) ([1c1db81](https://github.com/Kong/public-shared-actions/commit/1c1db81d4bc99d8c87058fba34203419a0fd0604))


### 🐛 Bug Fixes

* **ci:** Fix grype output file and dependency ([#38](https://github.com/Kong/public-shared-actions/issues/38)) ([45d3c9a](https://github.com/Kong/public-shared-actions/commit/45d3c9a9e2e8ea822429c745f9cd755e38879752))



# 1.3.0 (2023-06-08)


### ✨ Features

* **cd:** add trivy docker-cis scan ([#1](https://github.com/Kong/public-shared-actions/issues/1)) ([84f743c](https://github.com/Kong/public-shared-actions/commit/84f743cf7cfdf5e75dc81e5c158c7e3d6181ced4))
* **cd:** Use pinned tags instead of latest  ([4b6870c](https://github.com/Kong/public-shared-actions/commit/4b6870cbdd4a0c8b78d77e9a210de7fa9eecc18d))


### 🐛 Bug Fixes

* **cd:** only pass input flag to trivy action when docker tar is present ([cbe4f65](https://github.com/Kong/public-shared-actions/commit/cbe4f65b04769cf67756f52984fc8508207d5f64))


### ♻️ Chores

* **docs:** update readme to include trivy docker-cis ([ab12bb2](https://github.com/Kong/public-shared-actions/commit/ab12bb2e88ed367ab47d1110f698cbfa3c68c0c5))
* **sbom-action:** bump sbom action to 0.13.4 ([396a2e4](https://github.com/Kong/public-shared-actions/commit/396a2e4e87b05d84df19455395a64b5aa2a967a5))
