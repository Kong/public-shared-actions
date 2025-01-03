# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

# 4.0.0 (2025-01-03)


### ✨ Features

* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### 🐛 Bug Fixes

* moving actions that deal with PR preview packages from shared-actions [KHCP-7461] ([#18](https://github.com/Kong/public-shared-actions/issues/18)) ([a61b6ff](https://github.com/Kong/public-shared-actions/commit/a61b6ff5141d0692f3a0fe1c2bff5b4c1b63aee7))
* **validate:** check all pr formats ([#52](https://github.com/Kong/public-shared-actions/issues/52)) ([052816f](https://github.com/Kong/public-shared-actions/commit/052816facfea621ca1d555d69fb84cd9b4c446ec))


### Breaking changes

* **release:** - Each project within Public Shared Action is now treated as an independent package.
- Each package will have its own versioned release.
- Releases tag example "@security-actions/scan-docker-image@1.1.0".
- Markdown (.md) files will be ignored when determining changes for releases.
