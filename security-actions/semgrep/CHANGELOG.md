# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## [4.0.3](https://github.com/Kong/public-shared-actions/compare/@security-actions/semgrep@4.0.2...@security-actions/semgrep@4.0.3) (2025-08-20)


### ♻️ Chores

* **deps:** pin GitHub Actions to commit SHA ([#290](https://github.com/Kong/public-shared-actions/issues/290)) ([a5cfb79](https://github.com/Kong/public-shared-actions/commit/a5cfb7971a69f2de94e2c01b333e9368d7f0f29e))





## [4.0.2](https://github.com/Kong/public-shared-actions/compare/@security-actions/semgrep@4.0.1...@security-actions/semgrep@4.0.2) (2025-04-16)


### 🐛 Bug Fixes

* **deps:** install semgrep and zizmor as pip dependencies ([#244](https://github.com/Kong/public-shared-actions/issues/244)) ([fd9fa6b](https://github.com/Kong/public-shared-actions/commit/fd9fa6bd82468e01d8ee93de2e4c2c31c4d48bbd))





## [4.0.1](https://github.com/Kong/public-shared-actions/compare/@security-actions/semgrep@4.0.0...@security-actions/semgrep@4.0.1) (2025-03-19)


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))





# 4.0.0 (2025-01-03)


### ✨ Features

* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))
* **SEC-1211:** update semgrep version ([#154](https://github.com/Kong/public-shared-actions/issues/154)) ([6d6e601](https://github.com/Kong/public-shared-actions/commit/6d6e6019a116933a92b20091e597eaf835104714))


### ♻️ Chores

* **deps:** bump github/codeql-action/upload-sarif from v2 to v3 ([9d9c93f](https://github.com/Kong/public-shared-actions/commit/9d9c93f3941969daff746687035bf8157514a300))
* **docs:** update semgrep readme ([#195](https://github.com/Kong/public-shared-actions/issues/195)) ([1a06695](https://github.com/Kong/public-shared-actions/commit/1a06695f203736707ff37957b7174d17402ed5ea))
* **readme:** Add vulnerability migration and breakglass strategy for SCA and CVE action ([#107](https://github.com/Kong/public-shared-actions/issues/107)) ([ad89a25](https://github.com/Kong/public-shared-actions/commit/ad89a255ff44a03377215b8bccbfdc17c8c7fb46))


### Breaking changes

* **release:** - Each project within Public Shared Action is now treated as an independent package.
- Each package will have its own versioned release.
- Releases tag example "@security-actions/scan-docker-image@1.1.0".
- Markdown (.md) files will be ignored when determining changes for releases.



# 1.15.0 (2024-01-22)


### ♻️ Chores

* **ci:** configurable failure mode for semgrep ([#55](https://github.com/Kong/public-shared-actions/issues/55)) ([bc77fa6](https://github.com/Kong/public-shared-actions/commit/bc77fa65f43dfb6b3ef0b9d258c02faf5892aab1))
