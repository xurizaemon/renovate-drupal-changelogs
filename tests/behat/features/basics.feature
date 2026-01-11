@basics @api
Feature: site-basics
  In order to confirm the web and test frameworks are set up
  As an administrator
  I need to confirm that basic site functions work

  @drush
  # behat >       The "--nocolor" option does not exist.
  # behat >        (RuntimeException)
  # behat >     ╳  Fatal error: Call to a member function hasJavascriptDialog() on null (Behat\Testwork\Call\Exception\FatalThrowableError)
  # behat >     └─ @AfterStep # DrevOps\BehatScreenshotExtension\Context\ScreenshotContext::printLastResponseOnError()
  @skipped
  Scenario: The database is connected
    When I run drush "status" "--field=Database"
    Then drush output should contain "Connected"

  @drush
  @skipped
  Scenario: Ensure we have the standard roles available
    When I run drush "role-list"
    Then drush output should contain "Anonymous user"
    And drush output should contain "Authenticated user"
    And drush output should contain "Administrator"

  Scenario: Load the front page
    Given I set the configuration item "system.site" with key "page.front" to "/products"
    When I am on "/"
    Then the response status code should be 200
    And I should not see "The website encountered an unexpected error."

  Scenario: No anonymous access on /admin
    Given I am not logged in
    When I am on "/admin"
    Then I should get a 403 HTTP response

  Scenario: No standard user access on /admin
    Given I am logged in as a user with the "authenticated user" role
    When I am on "/admin"
    Then I should get a 403 HTTP response

  Scenario: Admin access on /admin
    Given I am logged in as a user with the "administrator" role
    When I am on "/admin"
    Then I should not see the heading "Access denied"

  Scenario: I can't login twice
    Given I am logged in as a user with the "authenticated user" role
    When I visit "/user"
    Then the URL should match "user/[A-Za-z0-9]+"

  Scenario: I can't register twice
    Given I am logged in as a user with the "authenticated user" role
    When I visit "user/register"
    Then the URL should match "user/\d+/edit"

  Scenario: Run cron
    Given I am logged in as a user with the "administrator" role
    When I run cron
    And am on "admin/reports/dblog"
    Then I should see the link "Cron run completed"
