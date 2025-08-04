# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

# 5.0.0 (2025-08-04)


### ✨ Features

* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### 🐛 Bug Fixes

* moving actions that deal with PR preview packages from shared-actions [KHCP-7461] ([#18](https://github.com/Kong/public-shared-actions/issues/18)) ([a61b6ff](https://github.com/Kong/public-shared-actions/commit/a61b6ff5141d0692f3a0fe1c2bff5b4c1b63aee7))
* **validate:** check all pr formats ([#52](https://github.com/Kong/public-shared-actions/issues/52)) ([052816f](https://github.com/Kong/public-shared-actions/commit/052816facfea621ca1d555d69fb84cd9b4c446ec))


### ♻️ Chores

* **ci:** use unscoped package names for git release tags ([#277](https://github.com/Kong/public-shared-actions/issues/277)) ([ed27e0b](https://github.com/Kong/public-shared-actions/commit/ed27e0b1baa15f43ad10420444bdd4f2fc2b3dab))
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
