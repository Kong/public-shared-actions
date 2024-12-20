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


# Setting Up Lefthook for Commit Message Verification

This guide will help you install and configure Lefthook to enforce commit message standards locally.

## Step 1: Install Lefthook

Lefthook is already listed within dev dependencies in the package.json file. Run `pnpm install` to install all the dependencies.

### Platforms specfic installation of Lefthook
Refer to the official Lefthook [installation guide](https://github.com/evilmartians/lefthook/blob/master/docs/install.md) for platform-specific instructions.

---

## Step 4: Sync Lefthook Hooks
This repo should already contain a `lefthook.yml` configuration file in the root directory. The configuration in the lefthook.yml file enforces commit message linting using Commitlint.
For a user to be able to use lefthook, run the following command to sync the Lefthook configuration with your Git hooks:

```bash
lefthook run pre-commit
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


