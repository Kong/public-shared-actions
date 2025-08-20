# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## [5.0.1](https://github.com/Kong/public-shared-actions/compare/scan-gh-workflows@5.0.0...scan-gh-workflows@5.0.1) (2025-08-20)


### ♻️ Chores

* **deps:** pin GitHub Actions to commit SHA ([#290](https://github.com/Kong/public-shared-actions/issues/290)) ([a5cfb79](https://github.com/Kong/public-shared-actions/commit/a5cfb7971a69f2de94e2c01b333e9368d7f0f29e))





# 5.0.0 (2025-08-04)


### ✨ Features

* **ci:** gha analyzer action for anti-patterns ([#214](https://github.com/Kong/public-shared-actions/issues/214)) ([fc095d4](https://github.com/Kong/public-shared-actions/commit/fc095d45e81a8107a5b710b4b6a67cf4b0cf6aa5))


### 🐛 Bug Fixes

* **deps:** install semgrep and zizmor as pip dependencies ([#244](https://github.com/Kong/public-shared-actions/issues/244)) ([fd9fa6b](https://github.com/Kong/public-shared-actions/commit/fd9fa6bd82468e01d8ee93de2e4c2c31c4d48bbd))


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))
* **ci:** use unscoped package names for git release tags ([#277](https://github.com/Kong/public-shared-actions/issues/277)) ([ed27e0b](https://github.com/Kong/public-shared-actions/commit/ed27e0b1baa15f43ad10420444bdd4f2fc2b3dab))
* **release:** publish [skip ci] ([21158ae](https://github.com/Kong/public-shared-actions/commit/21158ae3c9c2fdcb72c3fcedaf552e3f6007f05d))
* **release:** publish [skip ci] ([a18abf7](https://github.com/Kong/public-shared-actions/commit/a18abf762d6e2444bcbfd20de70451ea1e3bc1b1))
* **release:** publish [skip ci] ([f2b77d6](https://github.com/Kong/public-shared-actions/commit/f2b77d6aa619dbe3bfcc1ac4f99af7d02614e90a))


### Breaking changes

* **ci:** 'Release tags' now use 'unscoped' package names
Applications and Package managers using:
- Release Tag names will need update the package names to new format
- Pinned SHA are NOT affected

* feat(release): dry run

* fix(release): remove allow branch config used for dry run





## [4.1.2](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-gh-workflows@4.1.1...@security-actions/scan-gh-workflows@4.1.2) (2025-04-16)


### 🐛 Bug Fixes

* **deps:** install semgrep and zizmor as pip dependencies ([#244](https://github.com/Kong/public-shared-actions/issues/244)) ([fd9fa6b](https://github.com/Kong/public-shared-actions/commit/fd9fa6bd82468e01d8ee93de2e4c2c31c4d48bbd))





## [4.1.1](https://github.com/Kong/public-shared-actions/compare/@security-actions/scan-gh-workflows@4.1.0...@security-actions/scan-gh-workflows@4.1.1) (2025-03-19)


### ♻️ Chores

* **ci:** pin actions ([#231](https://github.com/Kong/public-shared-actions/issues/231)) ([b20e862](https://github.com/Kong/public-shared-actions/commit/b20e862374458b5a3be19d2934de79e0529e0c88))





# 4.1.0 (2025-02-27)


### ✨ Features

* **ci:** gha analyzer action for anti-patterns ([#214](https://github.com/Kong/public-shared-actions/issues/214)) ([fc095d4](https://github.com/Kong/public-shared-actions/commit/fc095d45e81a8107a5b710b4b6a67cf4b0cf6aa5))
