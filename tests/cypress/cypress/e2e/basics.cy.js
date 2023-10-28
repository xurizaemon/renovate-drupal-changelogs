describe('Drupal basics', () => {
  it('drush status', () => {
    cy.drush('status')
      .its('stdout')
      .should('match', /Database[\s:]+Connected/)
      .should('match', /Drupal bootstrap[\s:]+Successful/)
  })

  it('Front page loads', () => {
    cy.request('/').then((response) => {
      expect(response.status).to.eq(200)
    })
  })

  it('Anonymous user may not access /admin', () => {
    cy.request({url: '/admin', failOnStatusCode: false}).then((response) => {
      expect(response.status).to.eq(403)
    })
  })

  it('User "admin" may access /admin', () => {
    cy.loginUserByUsername('admin')
    cy.request('/admin').then((response) => {
      expect(response.status).to.eq(200)
    })
  })
})
