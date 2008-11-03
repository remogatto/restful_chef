Feature: Delete a recipe
  In order to keep clean the db
  As a restful_chef user
  I want to delete recipes

  Scenario: Delete a recipe
    Given I am on the dashboard
    And I have entered Spaghetti al pomodoro in the name form field
    And I press save button
    When I select Spaghetti al pomodoro
    And I click on the delete button
    Then the Spaghetti al pomodoro recipe should disappear from the grid