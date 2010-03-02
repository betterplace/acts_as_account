Feature: Transfer
  In order to transfer money from one account to another
  As a Bank
  I want not to loose money

  Scenario: I transfer 10 € from Thies's account to Norman's account
    Given I create an account for user Thies with 70 €
    Given I create an account for user Norman with 20 €
    Then Thies's account balance is 70 €
    Then Norman's account balance is 20 €
    When I transfer 30 € from Thies's account to Norman's account
    Then Thies's account balance is 40 €
    Then Norman's account balance is 50 €