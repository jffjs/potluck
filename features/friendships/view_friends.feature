Feature: View friends list
  
  In order to navigate to my friend's profiles
  As a user
  I want to view all of my friendships
  
  Scenario: View a list of all friends
    Given I am friends with a user with email "foo@bar.com" and name "Joe Schmoe"
    And I am friends with a user with email "baz@quack.com" and name "Jane Doe"
    When I follow "Friends"
    Then I should see "Joe Schmoe"
    And I should see "Jane Doe"
    
  Scenario: Visit a friend's profile through my friend's list
    Given I am friends with a user with email "foo@bar.com" and name "Joe Schmoe"
    When I follow "Friends"
    And I follow "Joe Schmoe"
    Then I should see "Joe Schmoe"
    And I should see "You are friends with"