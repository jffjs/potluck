Feature: Add a recipe
  
  In order to keep track of my favorite recipes
  As a user
  I want to add a new recipe to my collection
  
  @wip
  Scenario: Add a new recipe to my collection
    Given I am a registered user and signed in
    When I follow "Add a recipe"
    And I fill out the Recipe form
    Then I should see "Recipe added"
    And I should see a button with "Share it!"