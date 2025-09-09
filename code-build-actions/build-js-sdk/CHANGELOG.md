# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## [5.0.1](https://github.com/Kong/public-shared-actions/compare/build-js-sdk@5.0.0...build-js-sdk@5.0.1) (2025-09-09)


### ♻️ Chores

* **deps:** update PSA deps ([#296](https://github.com/Kong/public-shared-actions/issues/296)) ([72f8cd3](https://github.com/Kong/public-shared-actions/commit/72f8cd345ddaf10734bf8d4d4f6139892c1a4360))





# 5.0.0 (2025-08-04)


### ✨ Features

* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### 🐛 Bug Fixes

* **build-js-sdk:** hardcode src as the output directory ([#49](https://github.com/Kong/public-shared-actions/issues/49)) ([4517bad](https://github.com/Kong/public-shared-actions/commit/4517bad0f9414091f830ddc739cfc3df214d903a))
* use input string instead of boolean ([#50](https://github.com/Kong/public-shared-actions/issues/50)) ([3d93b96](https://github.com/Kong/public-shared-actions/commit/3d93b96af46a4f38d62cb65ab0c221aa3531522c))


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))
* **ci:** use unscoped package names for git release tags ([#277](https://github.com/Kong/public-shared-actions/issues/277)) ([ed27e0b](https://github.com/Kong/public-shared-actions/commit/ed27e0b1baa15f43ad10420444bdd4f2fc2b3dab))
* move build-js-sdk to public ([#34](https://github.com/Kong/public-shared-actions/issues/34)) ([7119dd2](https://github.com/Kong/public-shared-actions/commit/7119dd21a38e4fc6e879f9c9fff2e593966c43a5))
* **release:** publish [skip ci] ([a18abf7](https://github.com/Kong/public-shared-actions/commit/a18abf762d6e2444bcbfd20de70451ea1e3bc1b1))
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





## [4.0.1](https://github.com/Kong/public-shared-actions/compare/@code-build-actions/build-js-sdk@4.0.0...@code-build-actions/build-js-sdk@4.0.1) (2025-03-19)


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))





# 4.0.0 (2025-01-03)


### ✨ Features

* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### 🐛 Bug Fixes

* **build-js-sdk:** hardcode src as the output directory ([#49](https://github.com/Kong/public-shared-actions/issues/49)) ([4517bad](https://github.com/Kong/public-shared-actions/commit/4517bad0f9414091f830ddc739cfc3df214d903a))
* use input string instead of boolean ([#50](https://github.com/Kong/public-shared-actions/issues/50)) ([3d93b96](https://github.com/Kong/public-shared-actions/commit/3d93b96af46a4f38d62cb65ab0c221aa3531522c))


### ♻️ Chores

* move build-js-sdk to public ([#34](https://github.com/Kong/public-shared-actions/issues/34)) ([7119dd2](https://github.com/Kong/public-shared-actions/commit/7119dd21a38e4fc6e879f9c9fff2e593966c43a5))


### Breaking changes

* **release:** - Each project within Public Shared Action is now treated as an independent package.
- Each package will have its own versioned release.
- Releases tag example "@security-actions/scan-docker-image@1.1.0".
- Markdown (.md) files will be ignored when determining changes for releases.
