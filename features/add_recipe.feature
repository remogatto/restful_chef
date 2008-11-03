Feature: Add new recipe
  In order to populate recipe db
  As a restful_chef user
  I want to add a new recipe

  Scenario: Add new recipe
    Given I am on the dashboard
    And I have entered Spaghetti al pomodoro in the name form field
    When I press save button
    Then I should see the Spaghetti al pomodoro recipe on the grid
