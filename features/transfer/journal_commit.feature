Feature: Commit
  In order to transfer money through multiple account
  As a Bank
  I want my money to be on defined accounts in case of an error

  Scenario: Failed transfer leaves money on initial account
    Given I create a user A 
    Given I create a user B
    When I transfer 30 € from A's account to B's account
    And I don't commit
    Then the balance-sheet should be:
    | User | Balance |
    | A    | 0       |
    | B    | 0       |

  Scenario: Failed transfer after commit leaves money on last account before commit
    Given I create a user A  
    Given I create a user B
    When I transfer 30 € from A's account to B's account
    And I commit
    Then the balance-sheet should be:
    | User | Balance |
    | A    | -30     |
    | B    | 30      |

  Scenario: Failed transfer after commit leaves money on last account before commit
    Given I create a user A  
    Given I create a user B
    Given I create a user C  
    Given I create a user D
    When I transfer 30 € from A's account to B's account
    And I commit
    When I transfer 20 € from B's account to C's account
    When I transfer 10 € from B's account to D's account
    Then the balance-sheet should be:
    | User | Balance |
    | A    | -30     |
    | B    | 30      |
    | C    | 0       |
    | D    | 0       |
