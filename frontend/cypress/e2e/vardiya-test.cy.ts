describe('Vardiya Yönetim Sistemi - Test', () => {
  it('Vardiya listesini görüntüler ve kontrol eder', () => {
    // Ana sayfaya git
    cy.visit('/')

    // 10 saniye bekle (video için)
    cy.wait(10000)

    // Vardiya listesi görünür olmalı
    cy.get('[data-testid="shifts-list"]').should('be.visible')

    // En az 1 vardiya olmalı
    cy.get('[data-testid="shift-item"]').should('have.length.at.least', 1)

    // Her vardiya için kontroller
    cy.get('[data-testid="shift-item"]').each(($shift) => {
      // İsim var mı
      cy.wrap($shift).find('[data-testid="shift-name"]').should('be.visible')

      // Zaman bilgisi var mı
      cy.wrap($shift).find('[data-testid="shift-time"]').should('be.visible')

      // Açıklama var mı
      cy.wrap($shift).find('[data-testid="shift-description"]').should('be.visible')
    })
  })
})
