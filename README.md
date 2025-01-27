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


---

## Local commit validation with Lefthook

### Setting Up Lefthook

1. **Install Lefthook**:
   Run `pnpm install` to install Lefthook. 
  
2. **Sync Hooks**:
   Lefthook hooks are synced using the `prepare` script in root `package.json`:

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

### Commitlint Configuration

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

If a commit is made with an invalid scope, you will see an error as given below. The error will also list the available scopes which can be used in the commit message.

```bash
❯ git commit -S -m "feat(store): add renovate config"

⧗   input: feat(store): add renovate config
✖   scope must be one of [build-js-sdk, lua-lint, rust-lint, cleanup, up-to-date, validate, sca, scan-docker-image, scan-rust, semgrep, sign-docker-image, workflow-notification, release, deps, ci] [scope-enum]

✖   found 1 problems, 0 warnings
ⓘ   Get help: https://github.com/Kong/public-shared-actions
```

---

### Renovate Integration for Downstream Applications

Downstream applications can use **Renovate** to automatically update dependencies from Public Shared Actions. 

Downstream applications using Renovate to manage dependencies of `Kong/public-shared-actions` can extend the [https://github.com/Kong/public-shared-renovate/blob/main/github-actions.json](shared renovate configuration) within `<replace-with-renovate-config-file>` using the following entry:

  ```json
  {
    "extends": [
      "github>Kong/public-shared-renovate:github-actions"
    ]
  }
  ```

> Note: Dependabot is currently not supported.

**Important:** Ensure dependencies use pinned SHA digest formats such as `@digest # v2.8.0`.
