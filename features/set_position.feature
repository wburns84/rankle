Feature: Set position
  In order to assign a ranking
  As a developer
  I want to set an element's position

  Scenario: Update position attribute
    Given an apple
      And an orange
     When I update the apple's position attribute to 1
     Then the apple is in position 1
      And the orange is in position 0

  Scenario: Update position attribute
    Given an apple
      And an orange
     When I assign the apple's rank to 1
     Then the apple is in position 1
      And the orange is in position 0

  Scenario: Override default with stabby proc
    Given a fruit class with a reverse alphabetical default ranking on name
      And an apple
      And an orange
     Then the apple is in position 1
      And the orange is in position 0