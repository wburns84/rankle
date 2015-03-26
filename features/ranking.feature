Feature: Ranks
  In order to provide an explicit ordering
  As a developer
  I want to rank on order

  Scenario: Reverse ranking
    Given 10 rows
     When I rank them in reverse order
     Then ranking is equivalent to all reversed

  Scenario: Update ranking
    Given 10 rows in default order
     When I move row 9 to row 0
     Then ranking is equivalent to all rotated -1

  Scenario: Negative rank
    Given 10 rows in default order
    When I move row 9 to row -10
    Then row 9 is in position 0