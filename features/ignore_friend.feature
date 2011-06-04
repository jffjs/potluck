Feature: Ignore friendship request

  In order to avoid forming a friendship with an unknown user
  As a user
  I should be able to ignore a requested friendship
  
  Scenario: Ignore a requested friendship
    Given I am a user with an email "user@test.com" and password "password"
    And I am friended by a user with an email "foo@bar.com" and name "Joe Friend"
    When I sign in as "user@test.com/password"
    And I press "Ignore"
    Then I should see "Friendship request ignored"
    
  Scenario: Accept an ignored friendship via the user's profile
    Given I am a user with an email "user@test.com" and password "password"
    And I am friended by a user with an email "foo@bar.com" and name "Joe Friend"
    When I sign in as "user@test.com/password"
    And I press "Ignore"
    And I visit the user's profile
    Then I should see a button with "Accept"
    And I should not see a button with "Ignore"