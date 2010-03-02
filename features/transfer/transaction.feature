@pending
Feature: Transfer
  In order to transfer money from one account to another
  As a Bank
  I want to make sure that a correct double booking is done

  Background:
    Given I have a account named Thies with 10 €
    And I have a account named Norman
    
  Scenario: I transfer 10 € from Thies to Norman
    Given Thies has 100 €
    And Norman has 0 €
    When I transfer 10 € from Thies to Norman
    Then Thies has 90 €
    And Norman has 10 €
    And I have 1 Journal with:
      | Thies  | -10 |
      | Norman |  10 | 
