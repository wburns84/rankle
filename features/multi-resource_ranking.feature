Feature: Multi-resource ranking
  In order to rank multiple resources
  As a consumer of rankle
  I want to create a multi-resource ranking

  Scenario: Basic ranking
    Given a 'fruit' model
      And a 'vegetable' model
      And an 'apple' fruit
      And a 'carrot' vegetable
     When I assign the 'apple' fruit's 'produce' rank to '0'
      And I assign the 'carrot' vegetable's 'produce' rank to '1'
     Then the 'apple' fruit's 'default' rank is '0'
      And the 'carrot' vegetable's 'default' rank is '0'
      And the 'apple' fruit's 'produce' rank is '0'
      And the 'carrot' vegetable's 'produce' rank is '1'

  Scenario: Default ranking
    Given a 'fruit' model with a 'produce' ranking
      And a 'vegetable' model with a 'produce' ranking
      And an 'apple' fruit
      And a 'carrot' vegetable
     Then the 'apple' fruit's 'default' rank is '0'
      And the 'carrot' vegetable's 'default' rank is '0'
      And the 'apple' fruit's 'produce' rank is '0'
      And the 'carrot' vegetable's 'produce' rank is '1'
