const {
  utils: { getPackages }
} = require('@commitlint/config-lerna-scopes')

module.exports = {
  extends: ['@commitlint/config-conventional', '@commitlint/config-lerna-scopes'],
  rules: {
    // see: https://github.com/conventional-changelog/commitlint/blob/master/docs/reference-rules.md
    'scope-empty': [2, 'never'],
    'body-max-line-length': [0, 'always', Infinity], // Disable max line length
    'body-max-length': [0, 'always', Infinity], // Disable max body length
    'scope-enum': async (ctx) => [
      2,
      'always',
      [...(await getPackages(ctx)), 'release', 'deps', 'ci']
    ]
  },
// TODO:  Perform ignores based on Commit Author instead of Message to avoid spoofing
  // Temporary solution: Ignore function to ignore any commit message which match the regex.
  // Example commit message: `github-actions(deps): bump anchore/scan-action from 4.1.2 to 6.1.0` 
  ignores: [
    (message) => /^Bumps \[.+]\(.+\) from .+ to .+\.$/m.test(message),
  ],
  helpUrl: 'https://github.com/Kong/public-shared-actions',
}
