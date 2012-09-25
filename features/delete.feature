Feature: Delete
  As a Software Engineer
  I want to delete the user
  So I don't get confused by old entries

  Background:
    Given there is a local repo
    And there is a pairs file

  Scenario: Delete existing user
    When I run `git pair delete ae`
    Then the output should contain "Deleted ae: Alfred Einstein"
    When I run `git pair nt ae`
    Then the output should contain "There is no entry for ae"
