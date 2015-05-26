Feature: Named ranking
  In order to maintain multiple rankings on a single class
  As a developer
  I want to create named rankings

  Scenario: Reverse ranking
    Given an apple
      And an orange
     When I assign the 'apple' fruit's 'reverse' rank to '1'
     When I assign the 'orange' fruit's 'reverse' rank to '0'
     Then the 'apple' fruit's 'default' rank is '0'
      And the 'orange' fruit's 'default' rank is '1'
      And the 'apple' fruit's 'reverse' rank is '1'
      And the 'orange' fruit's 'reverse' rank is '0'

  Scenario: Growing ranking
    Given an apple
      And a banana
      And an orange
     When I assign the 'apple' fruit's 'reverse' rank to '2'
      And I assign the 'banana' fruit's 'reverse' rank to '1'
      And I assign the 'orange' fruit's 'reverse' rank to '0'
     Then the 'apple' fruit's 'default' rank is '0'
      And the 'banana' fruit's 'default' rank is '1'
      And the 'orange' fruit's 'default' rank is '2'
      And the 'apple' fruit's 'reverse' rank is '1'
      And the 'banana' fruit's 'reverse' rank is '2'
      And the 'orange' fruit's 'reverse' rank is '0'

  Scenario: Registered ranking
    Given a 'fruit' class with a 'reverse' ranking
      And an apple
      And a banana
      And an orange
     When I assign the 'apple' fruit's 'reverse' rank to '2'
      And I assign the 'banana' fruit's 'reverse' rank to '1'
      And I assign the 'orange' fruit's 'reverse' rank to '0'
     Then the 'apple' fruit's 'default' rank is '0'
      And the 'banana' fruit's 'default' rank is '1'
      And the 'orange' fruit's 'default' rank is '2'
      And the 'apple' fruit's 'reverse' rank is '2'
      And the 'banana' fruit's 'reverse' rank is '1'
      And the 'orange' fruit's 'reverse' rank is '0'