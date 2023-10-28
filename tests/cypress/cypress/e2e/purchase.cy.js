describe('Commerce purchase', () => {
  it('User can make purchase registering new account', () => {
    // A random string for username, email etc.
    const randomString = Cypress._.uniqueId(Date.now().toString());

    // Add a product to our cart, then visit checkout.
    cy.visit('/products/24-x-30-hiding-goat-print')
    cy.get('input.button--add-to-cart')
      .click()
    cy.get('a.cart-block--link__expand')
      .first()
      .click()
    cy.get('.cart-block--contents__links a')
      .click()
    cy.get('input#edit-checkout')
      .click()
    cy.get('h1.page-title')
      .should('contain', 'Login')

    // Checkout page 1: Register account.
    cy.get('input#edit-login-register-mail')
      .type(`${randomString}@example.org`)
    cy.get('input#edit-login-register-name')
      .type(`${randomString}`)
    cy.get('input#edit-login-register-password-pass1')
      .type('Password123!')
    cy.get('input#edit-login-register-password-pass2')
      .type('Password123!')
    cy.get('input#edit-login-register-register')
      .click()
    cy.get('h1.page-title')
      .should('contain', 'Order information')

    // Checkout page 2: Address, shipping, payment method.
    cy.get('input.given-name')
      .type(randomString)
    cy.get('input.family-name')
      .type(randomString)
    cy.get('input.address-line1')
      .type('1 Test Street')
    cy.get('input.locality')
      .type('Beverly Hills')
    cy.get('input.postal-code')
      .type('90210')
    cy.get('select.administrative-area')
      .select('California')
    // Shipping calculation runs after address complete.
    cy.wait(1000)
    cy.get('.button--primary.form-submit.btn-success')
      .click()
    cy.get('h1.page-title')
      .should('contain', 'Review')

    // Checkout page 3: Confirm.
    cy.get('.button--primary.form-submit.btn-success')
      .click()

    // Payment via DPS.
    cy.origin('https://sec.windcave.com', () => {
      cy.get('h1')
        .should('contain', 'Payment Checkout')
      cy.get('h1')
        .should('contain', 'Credit Card Payment')

      // DPS CC details.
      cy.get('input[name="CardNumber"]')
        .type('4111111111111111')
      cy.get('input[name="CardHolderName"]')
        .type('Cypress Anonymous')
      cy.get('select[name="DateExpiry_1"]')
        .select('11')
      cy.get('select[name="DateExpiry_2"]')
        .select('31')
      cy.get('input[name="Cvc2"]')
        .type('111')
      cy.get('.DpsPxPayOK')
        .click()

      cy.get('h1')
        .should('contain', 'Payment Checkout')

      // DPS confirmation.
      cy.get('.DpsPxPayOK')
        .click()
    })

    cy.get('.checkout-complete')
      .should('contain', 'Your order number is')
  })
})
