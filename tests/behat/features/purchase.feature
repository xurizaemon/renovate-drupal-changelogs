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
    And I fill in "Postal code" with "9010"
    Then I press "Recalculate shipping"
    And I wait 2 seconds
    And I wait for AJAX to finish
    And I select the radio button "Credit Card (PxPay)"
    And I wait 2 seconds
    Then I press "Continue to review"
    Then I press "Pay and complete purchase"
    And I wait 2 seconds
    # This is the PxPay hosted form.
    Then I fill in "Name On Card" with "Behat Anonymous"
    And I fill in "Card Number:" with "4111111111111111"
    And I fill in "CVC:" with "111"
    And I select "12" from "Expiry Date (MM)"
    And I select "31" from "Expiry Date (YY)"
    And I press "Submit"
    And I wait for AJAX to finish
    And I click "Next"
    # Back on Drupal now.
    Then I should see the text "Your order number is"
    And I save screenshot