# public-shared-actions
Shared actions available to both public and private repositories

## Usage
  
```yaml
- uses: Kong/public-shared-actions/<action-name>@<SHA>
```

For example:
  
```yaml
- uses:  Kong/public-shared-actions/code-build-actions/build-js-sdk@a18abf762d6e2444bcbfd20de70451ea1e3bc1b1 # v4.0.1
```

## How to keep Public Shared Action dependencies up-to-date in downstream workflows
The `public-shared-actions` (PSA) repository is a monorepo that hosts multiple GitHub Shared Actions, each with its own release. Updating PSA references in downstream workflows is a manual and often delayed process, leading to inconsistencies and slow adoption of changes. Since each shared action can have its own GitHub release, managing dependencies at the action level is essential. To address this, centralized dependency management needs to be introduced to automate across repositories by raising pull requests whenever a shared action is released, solving both timeliness and consistency challenges at scale.

### Using Renovate dependency manager
To ensure downstream workflows can get timely automated updates on releases of public shared actions, [Renovate](https://github.com/renovatebot/renovate) can be leveraged.

The [Public Shared Renovate](https://github.com/Kong/public-shared-renovate) config provides a centralized and reusable Renovate [configuration](https://github.com/Kong/public-shared-renovate/blob/main/github-actions.json) tailored for managing release updates of `Kong/public-shared-actions`. The shared renovate config for PSA can detect and updates action references in GitHub workflow files, supporting both versioned tags (e.g., `@v2.8.0`) and pinned digests (e.g., `@sha256:... # v2.8.0`).

**Usage**
- **Latest Version of the Shared Config**  
To use the latest version of the shared config from `Kong/public-shared-renovate`, add the following to the top of your `renovate.json` or `renovate-config.json` file:

```yaml
{
  "extends": [
    "github>Kong/public-shared-renovate:github-actions"
  ]
}
```

- **Specific Release Version**
To pin Renovate to a specific version of the shared config (e.g., 1.6.0), use:

```yaml
{
  "extends": [
    "github>Kong/public-shared-renovate:github-actions#1.6.0"
  ]
}
```

# Setting Up Lefthook for Commit Message Verification

This guide will help you install and configure Lefthook to enforce commit message standards locally.

## Step 1: Install Lefthook

Lefthook is already listed within dev dependencies in the package.json file. Run `pnpm install` to install all the dependencies.

### Platforms specfic installation of Lefthook
Refer to the official Lefthook [installation guide](https://github.com/evilmartians/lefthook/blob/master/docs/install.md) for platform-specific instructions.

---

## Step 4: Sync Lefthook Hooks
This repo should already contain a `lefthook.yml` configuration file in the root directory.

The lefthook hooks are synced as part of `pnpm install` command using a `postinstall` hook that runs the below command automatically

```bash
lefthook install
```

---

## Step 5: Verify Commit Message Linting

To verify that Lefthook is correctly set up:

1. Stage a file for commit:
   ```bash
   git add .
   ```

2. Attempt to commit with an invalid message:
   ```bash
   git commit -m "Test commitlint"
   ```
   You should see errors like:
    - ✖ subject may not be empty
    - ✖ type may not be empty
    - ✖ scope may not be empty

3. Test with a valid commit message:
   ```bash
   git commit -m "feat(ci): test commitlint for scope"
   ```
   This should pass without any issues.

---

## Additional Notes

- Ensure that all developers in your team follow this setup to maintain consistent commit message standards.
- Refer to the [Lefthook Usage Guide](https://github.com/evilmartians/lefthook/blob/master/docs/usage.md) for more advanced configurations and usage scenarios.

By setting up Lefthook, you ensure that all developers adhere to the commit message conventions..

# Setting Up zizmor for GH workflows Analysis

This guide will help you install and configure zizmor to analyze GH workflows and Actions locally.

## Step 1: Install zizmor
Installed as dependency during `pnpm install` along with all the other  dependencies.
