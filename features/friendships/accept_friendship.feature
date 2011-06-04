Feature: Accept friendship

  In order to form friendships with other users
  As a user
  I want to accept a requested friendship from another user
  
  Scenario: Accept a requested friendship
    Given I am a user with an email "user@test.com" and password "password"
    And I am friended by a user with an email "foo@bar.com" and name "Joe Friend"
    When I sign in as "user@test.com/password"
    And I press "Accept"
    Then I should see "You are now friends with Joe Friend"
    
  Scenario: View a user's profile and see that he is now your friend
    Given I am a user with an email "user@test.com" and password "password"
    And I am friended by a user with an email "foo@bar.com" and name "Joe Friend"
    When I sign in as "user@test.com/password"
    And I press "Accept"
    And I visit the profile of the user with email "foo@bar.com"
    Then I should see "You are friends"
    And I should not see a button with "Request friendship"