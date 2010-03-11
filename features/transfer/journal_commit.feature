Feature: Commit
  In order to transfer money through multiple account
  As a Bank
  I want my money to be on defined accounts after commit

  Background: Users
    Given I create a user A  
    Given I create a user B
    Given I create a user C  
    Given I create a user D

  Scenario: Failed transfer leaves money on initial account
    When I transfer 30 € from A's account to B's account
    And I don't commit
    Then the balance-sheet should be:
    | User | Balance |
    | A    | 0       |
    | B    | 0       |

  Scenario: No commit would not transfer money
    When I transfer 30 € from A's account to B's account
    And I commit
    Then the balance-sheet should be:
    | User | Balance |
    | A    | -30     |
    | B    | 30      |

  Scenario: No final commit after commit leaves money on account before last commit
    When I transfer 30 € from A's account to B's account
    And I commit
    When I transfer 20 € from B's account to C's account
    When I transfer 10 € from B's account to D's account
    And I don't commit
    Then the balance-sheet should be:
    | User | Balance |
    | A    | -30     |
    | B    | 30      |
    | C    | 0       |
    | D    | 0       |
    
  Scenario: Journal should know of uncommited transfers
    When I transfer 30 € from A's account to B's account
    Then the current Journal should know there are uncommited transfers
    When I commit
    Then the Journal should know all transfers were committed
    
