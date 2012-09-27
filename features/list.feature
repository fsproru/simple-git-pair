Feature: List
  As a Software Engineer
  I want to list all available pairs
  So I know who I can pair with

  Background:
    Given there is a local repo
    And there is a pairs file

  Scenario: List existing pairs
    When I run `git pair list`
    Then the output should contain "nt: Nikola Tesla\nae: Alfred Einstein"
