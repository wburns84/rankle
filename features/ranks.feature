Feature: Ranks
  In order to provide an explicit ordering
  As a developer
  I want to rank on order

  Scenario: Reverse ranking
    Given 10 rows
     When I rank them in reverse order
     Then ranking is equivalent to all reversed