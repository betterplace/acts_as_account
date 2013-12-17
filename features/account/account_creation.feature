Feature: Creating an Account
  Background: I have a User
    Given I create a user A

  Scenario: Every Holder should have a default Account
    Then User A has an Account named default

  Scenario: Creating a second Accounts with the same name for a Holder returns original account
    Given User A has an Account named default
    And I create an Account named default for User A
    Then I get the original account

  Scenario: Creating a Account with a different name
    And I create an Account named default for User A
    And I create an Account named not_default for User A
    Then I can get the default Account of User A
    Then I can get the not_default Account of User A

  Scenario: Race condition while creating account
    Given I have the same user in memory
    And I disable the account existence check on those
    When I call 'account' on both it should be possible
