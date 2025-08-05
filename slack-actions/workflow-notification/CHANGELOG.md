# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

# 5.0.0 (2025-08-04)


### ✨ Features

* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### 📚 Documentation

* **workflow-notification:** usage instructions ([#238](https://github.com/Kong/public-shared-actions/issues/238)) ([74da147](https://github.com/Kong/public-shared-actions/commit/74da147e52ce45af56adaa6451bcc9367a7848a7))


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))
* **ci:** use unscoped package names for git release tags ([#277](https://github.com/Kong/public-shared-actions/issues/277)) ([ed27e0b](https://github.com/Kong/public-shared-actions/commit/ed27e0b1baa15f43ad10420444bdd4f2fc2b3dab))
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



## 2.7.3 (2024-09-30)


### ✨ Features

* **slack:** new workflow inputs ([#163](https://github.com/Kong/public-shared-actions/issues/163)) ([28d20a1](https://github.com/Kong/public-shared-actions/commit/28d20a1f492927f35b00b317acd78f669c45f88b))



## 2.7.2 (2024-09-27)


### 🐛 Bug Fixes

* success not status ([#162](https://github.com/Kong/public-shared-actions/issues/162)) ([0aaaa49](https://github.com/Kong/public-shared-actions/commit/0aaaa49782e9028086feb943ec04e03e35e3f813))



## 2.7.1 (2024-09-27)


### 🐛 Bug Fixes

* **slack:** flip failure message ([#161](https://github.com/Kong/public-shared-actions/issues/161)) ([4cf2875](https://github.com/Kong/public-shared-actions/commit/4cf28753e54f4cf3768870b50e5b7879ed558a10))



# 2.7.0 (2024-09-27)


### ✨ Features

* slack workflow conclusion notifications ([#160](https://github.com/Kong/public-shared-actions/issues/160)) ([33942dd](https://github.com/Kong/public-shared-actions/commit/33942ddf9f69faad5d85c1fe63888c267bf83b0a))





## [4.0.1](https://github.com/Kong/public-shared-actions/compare/@slack-actions/workflow-notification@4.0.0...@slack-actions/workflow-notification@4.0.1) (2025-03-19)


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))





# 4.0.0 (2025-01-03)


### ✨ Features

* **release:** independent releases for public shared actions ([#201](https://github.com/Kong/public-shared-actions/issues/201)) ([3d24b7f](https://github.com/Kong/public-shared-actions/commit/3d24b7f70c912df037063a571e59e789f4e49fc2))


### Breaking changes

* **release:** - Each project within Public Shared Action is now treated as an independent package.
- Each package will have its own versioned release.
- Releases tag example "@security-actions/scan-docker-image@1.1.0".
- Markdown (.md) files will be ignored when determining changes for releases.



## 2.7.3 (2024-09-30)


### ✨ Features

* **slack:** new workflow inputs ([#163](https://github.com/Kong/public-shared-actions/issues/163)) ([28d20a1](https://github.com/Kong/public-shared-actions/commit/28d20a1f492927f35b00b317acd78f669c45f88b))



## 2.7.2 (2024-09-27)


### 🐛 Bug Fixes

* success not status ([#162](https://github.com/Kong/public-shared-actions/issues/162)) ([0aaaa49](https://github.com/Kong/public-shared-actions/commit/0aaaa49782e9028086feb943ec04e03e35e3f813))



## 2.7.1 (2024-09-27)


### 🐛 Bug Fixes

* **slack:** flip failure message ([#161](https://github.com/Kong/public-shared-actions/issues/161)) ([4cf2875](https://github.com/Kong/public-shared-actions/commit/4cf28753e54f4cf3768870b50e5b7879ed558a10))



# 2.7.0 (2024-09-27)


### ✨ Features

* slack workflow conclusion notifications ([#160](https://github.com/Kong/public-shared-actions/issues/160)) ([33942dd](https://github.com/Kong/public-shared-actions/commit/33942ddf9f69faad5d85c1fe63888c267bf83b0a))
