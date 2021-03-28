@screenshots @api
Feature: screenshots
  In order to see the site as it appears in CI
  As a developer
  I need to capture example screenshots and HTML

  Scenario: Capture the front page
    When I am on "/"
    Then I save screenshot
