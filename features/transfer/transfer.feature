Feature: Transfer
  In order to transfer money from one account to another
  As a Bank
  I want not to loose money

  Scenario: I transfer 10 € from Thies's account to Norman's account
    Given I create a user Thies
    Given I create a user Norman
    When I transfer 30 € from Thies's account to Norman's account
    And I commit
    Then Thies's account balance is -30 €
    And Norman's account balance is 30 €
