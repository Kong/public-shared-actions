const {
  utils: { getPackages }
} = require('@commitlint/config-lerna-scopes')

module.exports = {
  extends: ['@commitlint/config-conventional', '@commitlint/config-lerna-scopes'],
  rules: {
    // see: https://github.com/conventional-changelog/commitlint/blob/master/docs/reference-rules.md
    'scope-empty': [2, 'never'],
    'scope-enum': async (ctx) => [
      2,
      'always',
      [...(await getPackages(ctx)), 'release', 'deps', 'ci']
    ]
  },
  // TODO: Add a custom ignore function to ignore Dependabot commits
  // Temporary solution: Ignore function to ignore any commit message which match the regex.
  // Example commit message: `github-actions(deps): bump anchore/scan-action from 4.1.2 to 6.1.0` 
  ignores: [
    (message) => /^Bumps \[.+]\(.+\) from .+ to .+\.$/m.test(message),
  ],
  helpUrl: 'https://github.com/Kong/public-shared-actions',
}
