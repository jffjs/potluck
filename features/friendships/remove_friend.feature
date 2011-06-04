Feature: Remove friend

  In order to terminate and accepted friendship with another user
  As a user
  I should be able to remove friendship with another user
  
  Scenario: Initiate friendship removal and see confirmation
    Given I am friends with a user with email "foo@bar.com" and name "Joe Schmoe"
    When I visit the user's profile
    And I press "Remove friendship"
    Then I should see "Are you sure"
    And I should see a button with "Yes"
    And I should see a button with "No"
    
  Scenario: Confirm friendship removal
    Given I am friends with a user with email "foo@bar.com" and name "Joe Schmoe"
    When I visit the user's profile
    And I press "Remove friendship"
    And I press "Yes"
    Then I should see "You are no longer friends with"
    
  Scenario: Change your mind and don't confirm removal
    Given I am friends with a user with email "foo@bar.com" and name "Joe Schmoe"
    When I visit the user's profile
    And I press "Remove friendship"
    And I press "No"
    Then I should not see "You are no longer friends with"
    And I should see a button with "Remove friendship"