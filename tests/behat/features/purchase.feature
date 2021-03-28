@purchase @api
Feature: purchase
  In order to demonstrate Commerce
  As a visitor
  I need to complete a purchase

  Scenario: Purchase a product
    When I am on "/"
    Then I click "Cold Pressed Juice"
    Then I press "Add to cart"
    And I wait for AJAX to finish
    Then I click "View cart"
    Then I press "Checkout"
    Then I press "Continue as Guest"
    Then I select "New Zealand" from "Country"
    And I wait for AJAX to finish
    And I fill in "First name" with "Firstname"
    And I fill in "Last name" with "Lastname"
    And I fill in "Street address" with "123 Example Street"
    And I fill in "City" with "Everywhere"
    And I fill in "Postal code" with "1234"
    Then I press "Recalculate shipping"
    Then I save screenshot
    And I wait for AJAX to finish
    And I fill in "CVV" with "123"
    Then I press "Continue to review"
    Then I save screenshot
    Then I press "Pay and complete purchase"
    Then I save screenshot
