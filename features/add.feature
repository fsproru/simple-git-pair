Feature: Add
  As a Software Engineer
  I want to add my collegue's name
  So I can pair him up

  Scenario: Add non existent pair
    Given there is a local repo
    And there is a pairs file
    When I run `git pair add ng New Guy`
    And I run `git pair nt ng`
    Then the output should contain "Nikola Tesla & New Guy"
