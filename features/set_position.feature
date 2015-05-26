Feature: Set position
  In order to assign a ranking
  As a developer
  I want to set an element's position

  Scenario: Update position attribute
    Given an empty fruit model
      And an 'apple' fruit
      And an 'orange' fruit
     When I update the apple's position attribute to 1
     Then the apple is in position 1
      And the orange is in position 0
     Then the ranked fruit array is [orange, apple]

  Scenario: Update position attribute with rank method
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

  Scenario: Override default with stabby proc (documentation)
    Given a fruit class with an alphabetical default ranking on name
      And an apple
      And an orange
      And a banana
     Then the apple is in position 0
      And the banana is in position 1
      And the orange is in position 2