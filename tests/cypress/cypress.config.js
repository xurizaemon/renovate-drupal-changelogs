const { defineConfig } = require("cypress");

module.exports = defineConfig({
  reporter: 'junit',
  reporterOptions: {
    mochaFile: 'results/cypress.xml',
  },
  e2e: {
    baseUrl: 'http://commerce-demo.lndo.site',
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
