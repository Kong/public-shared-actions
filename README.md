# public-shared-actions
Shared actions available to both public and private repositories

## Usage
  
```yaml
- uses: Kong/public-shared-actions/<action-name>@<tag>
```

For example:
  
```yaml
- uses:  Kong/public-shared-actions/code-build-actions/build-js-sdk@v1.6.0
```


## Technical Details for Public Shared Actions Package Level Releases

Outlines the technical implementation and workflows used to manage **independent releases** for each package within the Public Shared Actions repository.

---

### Root Configuration Files

#### 1. `package.json`

Defines project metadata and scripts for versioning, linting, and Lefthook setup. Key scripts include:

- **`version:ci`**: Automates versioning and GitHub release creation using Lerna.
- **`version:dry-run`**: Simulates a release process for testing purposes.
- **`prepare`**: Runs Lefthook to sync Git hooks.

#### 2. `lerna.json`

Configures **Lerna** for independent versioning and GitHub release creation. Example configuration:
- **`packages`**: `packages` property which will tell Lerna where to look for package.json files.
- **`ignoreChanges`**: Ingores any .md file change within the packages to avoid unwanted releases.
- **`version: independent`**: When using the independent mode, every package is versioned separately.
- **`conventionalCommits:true`**: When run with this flag, lerna version will use the [Conventional Commits Specification](https://www.conventionalcommits.org/en/) to determine the version bump and generate CHANGELOG.md files.
- **`allowBranch`**: Enables lerna on main branch. With this configutation, the lerna version will fail when run from any branch other than main. It is considered a best-practice to limit lerna version to the primary branch alone.

```json
{
  "version": "independent",
  "npmClient": "pnpm",
  "packages": [
    "code-build-actions/**",
    "code-check-actions/**",
    "login-aws-cloud",
    ---SNIPPED---
  ],
  "ignoreChanges": ["**/*.md"],
  "command": {
    "version": {
      "message": "chore(release): publish [skip ci]",
      "allowBranch": ["main"],
      "conventionalCommits": true,
      "changelogPreset": "metahub"
    }
  }
}
```

---

### GitHub Workflows

#### CI Workflow (`ci.yml`)

Validates pull requests and pushes to `main`. It performs the following tasks:

- **Install Dependencies**: Uses PNPM to manage packages efficiently.
- **Validate Commit Messages**: Enforces Conventional Commit standards with `commitlint`.
- **Linting**: Runs ESLint to ensure code quality.
- **Slack Notifications**: Sends success or failure notifications to Slack channels `#notify-public-shared-actions` & `#alert-public-shared-actions`

#### Release Workflow (`release.yml`)

Triggers automatically after a successful CI workflow or manually via `workflow_dispatch`. Key steps:

1. **Check for Changes**:
   - Uses `lerna changed` to detect modified packages.
   - Skips the release process if no changes are detected.

2. **Create Releases**:
   - Runs `pnpm version:ci` to version packages, tag them, and create GitHub releases.

3. **Slack Notifications**:
   - Notifies stakeholders about successful or failed releases, including details of published packages.

4. **Dry-Run Mode**:
   - `version:dry-run` supports testing the release process without committing or tagging actual changes.

##### Release Example

Below is an example of how release tags will look for specific packages:

- `@security-actions/scan-rust@4.0.1`
- `@code-check-actions/rust-lint@4.0.1`
- `@security-actions/sign-docker-image@4.0.1`
- `@slack-actions/workflow-notification@4.0.0`

Each tag is automatically generated during the release process based on detected changes in the respective package. These tags follow Semantic Versioning (SemVer) and include the scope and version number.

---

### Local Validation with Lefthook

#### Setting Up Lefthook

1. **Install Lefthook**:
   Run `pnpm install` to install Lefthook and other dependencies. 
  
2. **Sync Hooks**:
   Lefthook hooks are synced using the `prepare` script in `package.json`:

   ```bash
   lefthook run pre-commit
   ```

3. **Verify Commit Message Linting**:
   - Stage files: `git add .`
   - Test invalid commit: `git commit -m "Test commitlint"`
   - Test valid commit: `git commit -m "feat(ci): add linting setup"`

4. **Sample Configuration (`lefthook.yml`)**:
   ```yaml
   commit-msg:
     commands:
       commitlint:
         run: pnpm commitlint --edit
   ```

#### Commitlint Configuration

The `commitlint` configuration ensures that commit messages follow the Conventional Commit standard and restricts scopes to a predefined list of valid options. Invalid scopes will result in an error.

**Configuration File (`commitlint.config.js`):**

```javascript
---SNIPPED---
  extends: ['@commitlint/config-conventional', '@commitlint/config-lerna-scopes'],
  rules: {
    'scope-empty': [2, 'never'],
    'scope-enum': async (ctx) => [
      2,
      'always',
      [...(await getPackages(ctx)), 'release', 'deps', 'ci']
---SNIPPED---
```

**Error Example:**

If a commit is made with an invalid scope:

```bash
❯ git commit -S -m "feat(store): add renovate config"

⧗   input: feat(store): add renovate config
✖   scope must be one of [build-js-sdk, lua-lint, rust-lint, cleanup, up-to-date, validate, sca, scan-docker-image, scan-rust, semgrep, sign-docker-image, workflow-notification, release, deps, ci] [scope-enum]

✖   found 1 problems, 0 warnings
ⓘ   Get help: https://github.com/Kong/public-shared-actions
```

Ensure that your commit messages use only the allowed scopes to pass validation.

---

### Renovate Integration for Downstream Applications

#### Renovate Configuration

Downstream applications can use **Renovate** to automatically update dependencies from Public Shared Actions. 

- Below mentioned config for renovate extends the shared config within [Kong/public-shared-renovate](https://github.com/Kong/public-shared-renovate/blob/main/github-actions.json) repository.
- Example config for Renovate in downstream applications, updates to actions configured within `Kong/public-shared-actions` can be managed and automated using this config entry file when specified in downstream repositories.

  ```json
  {
    "extends": [
      "github>Kong/public-shared-renovate:github-actions"
    ]
  }
  ```

> Note: Dependabot is currently not supported.

#### Key Features of using this Renovate config

- Automatically detects changes and raises PRs in downstream repositories.
- Ensures dependencies are pinned with SHA digests for integrity.

**Important:** Ensure dependencies use pinned SHA digest formats such as `@digest # v2.8.0`.


### Contracts, Expectations & Agreements

1. **Commit Standards:**

   - All contributors must follow Conventional Commit standards.
   - Pre-commit hooks (using Lefthook) validate commit messages locally.
   - CI workflows block PRs with invalid commit messages.

2. **Independent Releases:**

   - Changes in one package will only trigger version bumps and releases for that specific package.
   - Release tags follow the format `@<package-name>@<version>` (e.g., `@code-check-actions@1.2.0`).

3. **Release Automation:**

   - Pushes to `main` automatically trigger the CI workflow which if successful automatically triggers the release workflow for changed packages.
   - Engineers can use `workflow_dispatch` to test dry-run releases.

4. **Slack Notifications:**

   - CI/Release workflow success notifications will be sent to Slack channel `#notify-public-shared-actions`.
   - CI/Release workflow failure alerts will be sent to Slack channel `#alert-public-shared-actions`.

5. **Downstream Consumption:**

   - Downstream applications are expected to use **Renovate** to update dependencies from this repository.
   - A shared Renovate configuration is available at [Kong/public-shared-renovate](https://github.com/Kong/public-shared-renovate/blob/main/github-actions.json).
