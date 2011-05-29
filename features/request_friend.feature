Feature: Request friendship

  In order to share recipes with people I know
  As a user
  I want to request friendship with another user
  
  Scenario: Request friendship with a user
    Given a user with an email "friend@test.com" and name "A Friend"
    And I am a user with an email "user@test.com" and password "password"
    When I sign in as "user@test.com/password"
    And I visit the profile of the user with email "friend@test.com"
    And I press "Request friendship"
    Then I should see "Friendship requested"
    
  Scenario: Requested friendship by another user
    Given I am a user with an email "user@test.com" and password "password"
    And I am friended by a user with an email "foo@bar.com" and name "Friend"
    When I sign in as "user@test.com/password"
    Then I should see "Friend requested friendship"
    And I should see "Accept"
    And I should see "Ignore"