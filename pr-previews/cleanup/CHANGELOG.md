# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

# 5.0.0 (2025-08-04)


### ✨ Features

* limit cleanup to versions created in last X days [KHCP-7885] ([#58](https://github.com/Kong/public-shared-actions/issues/58)) ([3c05dce](https://github.com/Kong/public-shared-actions/commit/3c05dce1fddb81fa49b2eb6c57e613be238bb917))
* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### 🐛 Bug Fixes

* **ci:** handle err exit in cleanup action [KHCP-14704] ([#227](https://github.com/Kong/public-shared-actions/issues/227)) ([89eab72](https://github.com/Kong/public-shared-actions/commit/89eab72e4eaf35b968461bcc66f6ed904fb278f5))
* cleanup starting with newer PR versions [KHCP-7461] ([#44](https://github.com/Kong/public-shared-actions/issues/44)) ([92fb10e](https://github.com/Kong/public-shared-actions/commit/92fb10ede738f04f917230d01da70ec0c69ce4b3))
* do not attempt to proceed already removed version [KHCP-7885] ([#59](https://github.com/Kong/public-shared-actions/issues/59)) ([32dac54](https://github.com/Kong/public-shared-actions/commit/32dac54b94ba0e1c2d1ab7e9c78543dc8ad358d5))
* moving actions that deal with PR preview packages from shared-actions [KHCP-7461] ([#18](https://github.com/Kong/public-shared-actions/issues/18)) ([a61b6ff](https://github.com/Kong/public-shared-actions/commit/a61b6ff5141d0692f3a0fe1c2bff5b4c1b63aee7))


### ♻️ Chores

* **ci:** use unscoped package names for git release tags ([#277](https://github.com/Kong/public-shared-actions/issues/277)) ([ed27e0b](https://github.com/Kong/public-shared-actions/commit/ed27e0b1baa15f43ad10420444bdd4f2fc2b3dab))
* **release:** publish [skip ci] ([428b759](https://github.com/Kong/public-shared-actions/commit/428b7594b70fc76d6929d769ac937169ac87f576))
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





## [4.0.1](https://github.com/Kong/public-shared-actions/compare/@pr-previews/cleanup@4.0.0...@pr-previews/cleanup@4.0.1) (2025-03-07)


### 🐛 Bug Fixes

* **ci:** handle err exit in cleanup action [KHCP-14704] ([#227](https://github.com/Kong/public-shared-actions/issues/227)) ([89eab72](https://github.com/Kong/public-shared-actions/commit/89eab72e4eaf35b968461bcc66f6ed904fb278f5))





# 4.0.0 (2025-01-03)


### ✨ Features

* limit cleanup to versions created in last X days [KHCP-7885] ([#58](https://github.com/Kong/public-shared-actions/issues/58)) ([3c05dce](https://github.com/Kong/public-shared-actions/commit/3c05dce1fddb81fa49b2eb6c57e613be238bb917))
* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### 🐛 Bug Fixes

* cleanup starting with newer PR versions [KHCP-7461] ([#44](https://github.com/Kong/public-shared-actions/issues/44)) ([92fb10e](https://github.com/Kong/public-shared-actions/commit/92fb10ede738f04f917230d01da70ec0c69ce4b3))
* do not attempt to proceed already removed version [KHCP-7885] ([#59](https://github.com/Kong/public-shared-actions/issues/59)) ([32dac54](https://github.com/Kong/public-shared-actions/commit/32dac54b94ba0e1c2d1ab7e9c78543dc8ad358d5))
* moving actions that deal with PR preview packages from shared-actions [KHCP-7461] ([#18](https://github.com/Kong/public-shared-actions/issues/18)) ([a61b6ff](https://github.com/Kong/public-shared-actions/commit/a61b6ff5141d0692f3a0fe1c2bff5b4c1b63aee7))


### Breaking changes

* **release:** - Each project within Public Shared Action is now treated as an independent package.
- Each package will have its own versioned release.
- Releases tag example "@security-actions/scan-docker-image@1.1.0".
- Markdown (.md) files will be ignored when determining changes for releases.
