@basics @api
Feature: site-basics
  In order to confirm the web and test frameworks are set up
  As an administrator
  I need to confirm that basic site functions work

  @drush
  Scenario: The database is connected
    When I run drush "status" "Database"
    Then drush output should contain "Connected"

  @drush
  Scenario: Ensure we have the standard roles available
    When I run drush "role-list"
    Then drush output should contain "Anonymous user"
    And drush output should contain "Authenticated user"
    And drush output should contain "Administrator"

  Scenario: Load the front page
    When I am on "/"
    Then the response status code should be 200
    And I should not see "The website encountered an unexpected error."

  Scenario: Load the front page
    When I am on "/"
    Then the response status code should be 200
    And I should not see "The website encountered an unexpected error."

  Scenario: No anonymous access on /admin
    Given I am not logged in
    When I am on "/admin"
    Then I should get a 403 HTTP response

  Scenario: No standard user access on /admin
    Given I am logged in as a user with the "authenticated user" role and I have the following fields:
      | status | 1 |
    When I am on "/admin"
    Then I should get a 403 HTTP response

  Scenario: Admin access on /admin
    Given I am logged in as a user with the "administrator" role and I have the following fields:
      | status | 1 |
    When I am on "/admin"
    Then I should not see the heading "Access denied"

  Scenario: I can't login twice
    Given I am logged in as a user with the "authenticated user" role and I have the following fields:
      | status | 1 |
    When I visit "/user"
    Then the URL should match "user/[A-Za-z0-9]+"

  Scenario: I can't register twice
    Given I am logged in as a user with the "authenticated user" role and I have the following fields:
      | status | 1 |
    When I visit "user/register"
    Then the URL should match "user/\d+/edit"

  Scenario: Run cron
    Given I am logged in as a user with the "administrator" role
    When I run cron
    And am on "admin/reports/dblog"
    Then I should see the link "Cron run completed"
