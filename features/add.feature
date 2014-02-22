Feature: Add
  As a Software Engineer
  I want to add my collegue's name
  So I can pair him up

  Background:
    Given there is a local repo
    And there is a pairs file

  Scenario: Add non existing pair
    When I run `git pair add ng New Guy`
    And I run `git pair nt ng`
    Then the output should contain "Nikola Tesla & New Guy"

  Scenario: Update existing pair
    When I run `git pair add ae Another Einstein` interactively
    And I type "yes"
    And I wait 2 seconds
    And I run `git pair nt ae`
    Then the output should contain "Nikola Tesla & Another Einstein"

  Scenario: Don't update existing pair
    When I run `git pair add ae Another Einstein` interactively
    And I type "no"
    Then the output should contain "Another Einstein was not added"
    And I run `git pair nt ae`
    Then the output should contain "Nikola Tesla & Alfred Einstein"
