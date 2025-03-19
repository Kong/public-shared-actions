# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## [4.0.2](https://github.com/Kong/public-shared-actions/compare/@code-check-actions/lua-lint@4.0.1...@code-check-actions/lua-lint@4.0.2) (2025-03-19)


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))
* **ci:** update readme ([#230](https://github.com/Kong/public-shared-actions/issues/230)) ([fc6e04c](https://github.com/Kong/public-shared-actions/commit/fc6e04c93dfe6378d7bd635cf6c355edf1c54e9d))





## [4.0.1](https://github.com/Kong/public-shared-actions/compare/@code-check-actions/lua-lint@4.0.0...@code-check-actions/lua-lint@4.0.1) (2025-01-16)


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



## 2.2.3 (2024-05-07)


### ✨ Features

* **lua-lint:** add an option to make the action fail if the linting fails ([#121](https://github.com/Kong/public-shared-actions/issues/121)) ([a98be01](https://github.com/Kong/public-shared-actions/commit/a98be0184f832cb24a9dd233f99074e8ba17b488))


### ♻️ Chores

* **readme:** Add vulnerability migration and breakglass strategy for SCA and CVE action ([#107](https://github.com/Kong/public-shared-actions/issues/107)) ([ad89a25](https://github.com/Kong/public-shared-actions/commit/ad89a255ff44a03377215b8bccbfdc17c8c7fb46))



# 1.15.0 (2024-01-22)



# 1.14.0 (2024-01-12)


### 🐛 Bug Fixes

* **lint:** does not specify global standard in luacheck command line arguments ([#57](https://github.com/Kong/public-shared-actions/issues/57)) ([2804623](https://github.com/Kong/public-shared-actions/commit/28046231055b99899d55d32eda2a5f4a6075db36))


### ♻️ Chores

* **ci:** configurable failure mode for semgrep ([#55](https://github.com/Kong/public-shared-actions/issues/55)) ([bc77fa6](https://github.com/Kong/public-shared-actions/commit/bc77fa65f43dfb6b3ef0b9d258c02faf5892aab1))



# 1.10.0 (2023-06-26)



# 1.8.0 (2023-06-26)


### 📦 Code Refactoring

* **sca:** Separate linters and sca for rust ([#46](https://github.com/Kong/public-shared-actions/issues/46)) ([b037b99](https://github.com/Kong/public-shared-actions/commit/b037b9950d987b47b5caf3d418fa09ffc046e6ca))
