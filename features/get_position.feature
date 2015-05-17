Feature: Get position
  In order to inspect a ranking
  As a developer
  I want to retrieve an element's position

  Scenario: Default ranking
    Given an apple
      And an orange
     Then the apple is in position 0
      And the orange is in position 1

  Scenario: Custom ranking
    Given an apple
      And an orange
     When I move the apple to position 1
     Then the apple is in position 1
      And the orange is in position 0