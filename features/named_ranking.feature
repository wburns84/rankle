Feature: Named ranking
  In order to maintain multiple rankings on a single class
  As a developer
  I want to create named rankings

  Scenario: Reverse ranking
    Given an apple
      And an orange
     When I assign the apple's 'reverse' rank to '1'
     When I assign the orange's 'reverse' rank to '0'
     Then the apple's 'default' rank is '0'
      And the orange's 'default' rank is '1'
      And the apple's 'reverse' rank is '1'
      And the orange's 'reverse' rank is '0'

  Scenario: Reverse ranking
    Given an apple
      And a banana
      And an orange
     When I assign the apple's 'reverse' rank to '2'
      And I assign the banana's 'reverse' rank to '1'
      And I assign the orange's 'reverse' rank to '0'
     Then the apple's 'default' rank is '0'
      And the banana's 'default' rank is '1'
      And the orange's 'default' rank is '2'
      And the apple's 'reverse' rank is '1'
      And the banana's 'reverse' rank is '2'
      And the orange's 'reverse' rank is '0'
