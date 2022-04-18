@purchase @api
Feature: purchase
  In order to demonstrate Commerce
  As a visitor
  I need to complete a purchase

  Scenario: Purchase a product
    When I am on "/product/26"
    Then I press "Add to cart"
    And I wait for AJAX to finish
    Then I click "your cart"
    Then I press "Checkout"
    Then I fill in "Email address" with "<?username>@example.org"
    And I fill in "Username" with "<?username>" in the "LoginNewCustomer" region
    And I fill in "Password" with "Password123!" in the "LoginNewCustomer" region
    And I fill in "Confirm password" with "Password123!" in the "LoginNewCustomer" region
    And I press "Create account and continue"
    Then I select "United States" from "Country"
    And I wait for AJAX to finish
    And I select "California" from "State"
    And I fill in "Zip code" with "90210"
    And I fill in "Street address" with "123 Example Street"
    And I fill in "City" with "Anywhere"
    And I fill in "First name" with "Firstname"
    And I fill in "Last name" with "Lastname"
    And I wait for AJAX to finish
    Then I press "Recalculate shipping"
    And I wait for AJAX to finish
    And I press "Continue to review"
    And I wait for AJAX to finish
    And I press "Pay and complete purchase"
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
