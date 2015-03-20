Feature: Default order
  In order to not surprise new customers
  As an author of rankle
  I want the default behavior to match existing behavior 

  Scenario: Empty point model
    Given an empty point model
     Then ranking all has no effect
     
  Scenario: Point model with several points
    Given several points
     Then ranking all has no effect