Feature: Default ranking
  In order to not surprise new customers
  As a consumer of rankle
  I want the default behavior to match existing behavior 

  Scenario: Empty fruit model
    Given an empty fruit model
     Then ranking all has no effect
     
  Scenario: Fruit model with several fruits
    Given several fruits
     Then ranking all has no effect

  Scenario: Ranked fruit
    Given an empty fruit model
      And an apple
      And an orange
     Then the ranked fruit array is [:apple, :orange]