module.exports = {
  constraints: {
    php: process.env.PHP_VERSION_CONSTRAINT
  },
  endpoint: process.env.CI_API_V4_URL,
  platform: 'gitlab',
  token: process.env.GITLAB_ACCESS_TOKEN,
  repositories: [
    process.env.CI_PROJECT_PATH
  ],
};
