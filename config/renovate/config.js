module.exports = {
  endpoint: process.env.CI_API_V4_URL,
  token: process.env.GITLAB_ACCESS_TOKEN,
  platform: 'gitlab',
  enabledManagers: [
    'composer',
    'npm',
  ],
  prHourlyLimit: 0,
  rebaseWhen: 'behind-base-branch',
  constraints: {
    php: process.env.PHP_VERSION_CONSTRAINT
  },
  onboardingConfig: {
    extends: [
      'config:recommended',
      ':preserveSemverRanges',
      ':rebaseStalePrs',
      ':enableVulnerabilityAlertsWithLabel(\'security\')',
      'group:recommended',
    ],
  },
  repositories: [
    process.env.CI_PROJECT_PATH
  ],
};
