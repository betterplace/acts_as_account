Feature: Transaction
  In order to create an account
  As a Bank
  I want to have an account with opening balance
  
  Scenario: I create an account for user Norman with 10 € opening balance
    Given I create an account for user Norman with 10 €
    Then an account for user Norman exists
    And the account has 1 journal
    And the journal has 1 posting with 10 €
    And the account's balance is 10 €
