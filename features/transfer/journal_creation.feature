Feature: Creating a journal

  Scenario: Creating a Journal via new or create is not possible
    When I create a Journal via new
    Then I fail with NoMethodError
    When I create a Journal via create
    Then I fail with NoMethodError
    When I create a Journal via create!
    Then I fail with NoMethodError

  Scenario: Creating a Journal via current
    When I create a Journal via current
    Then I have a Journal