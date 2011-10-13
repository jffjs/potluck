Feature: View recipes

  In order to see the latest recipes and my own collection
  As I user
  I want to view a list of recipes added

  Scenario: View a list of all my recipes
    Given I am a registered user and signed in
    And I have added 5 recipes
    When I go to my recipes page
    Then I should see my 5 recipes

  @wip
  Scenario: Viewing my recipes, I should only see recipes I created
