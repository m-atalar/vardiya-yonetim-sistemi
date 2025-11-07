import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Given("kullanıcı ana sayfada", () => {
  cy.visit("/");
});

When("sayfa yüklendiğinde", () => {
  cy.wait(10000); // 10 saniye bekleme - video süresi için
});

Then("vardiya listesi görünür olmalı", () => {
  cy.get('[data-testid="shifts-list"]').should("be.visible");
});

Then("en az {int} vardiya gösterilmeli", (count: number) => {
  cy.get('[data-testid="shift-item"]').should("have.length.at.least", count);
});

Then("her vardiya için isim gösterilmeli", () => {
  cy.get('[data-testid="shift-item"]').each(($el) => {
    cy.wrap($el).find('[data-testid="shift-name"]').should("be.visible");
  });
});

Then("her vardiya için zaman bilgisi gösterilmeli", () => {
  cy.get('[data-testid="shift-item"]').each(($el) => {
    cy.wrap($el).find('[data-testid="shift-time"]').should("be.visible");
  });
});

Then("her vardiya için açıklama gösterilmeli", () => {
  cy.get('[data-testid="shift-item"]').each(($el) => {
    cy.wrap($el).find('[data-testid="shift-description"]').should("be.visible");
  });
});
