Feature: Transfer
  In order to transfer money from one account to another
  As a Bank
  I want not to loose money

  Scenario: I transfer money between accounts having holders
    Given I create a user Thies
    Given I create a user Norman
    When I transfer 30 € from Thies's account to Norman's account
    And I commit
    Then Thies's account balance is -30 €
    And Norman's account balance is 30 €
    
  Scenario: I transfer money between global accounts
    Given I create a global wirecard account
    Given I create a global anonymous_donation account
    When I transfer 30 € from global wirecard account to global anonymous_donation account
    And I commit
    Then the global wirecard account balance is -30 €
    And the global anonymous_donation account balance is 30 €
