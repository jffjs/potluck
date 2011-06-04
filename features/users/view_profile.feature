Feature: View user profile
  
  In order to friend or see a user's shared recipes
  As a user
  I want to view another user's profile
  
  Scenario: View a user's profile while signed out
    Given a user with an email "user@test.com" and name "Jeff S"
    When I visit the profile of the user with email "user@test.com"
    Then I should see "Jeff S"
    And I should not see a button with "Request friendship"
    
  Scenario: View a user's profile while signed in
    Given a user with an email "user@test.com" and name "Jeff S"
    And I am a user with an email "foo@bar.com" and password "password"
    When I sign in as "foo@bar.com/password"
    And I visit the profile of the user with email "user@test.com"
    Then I should see "Jeff S"
    And I should see a button with "Request friendship"
    
  Scenario: Current user views own profile
    Given I am a user with an email "user@test.com" and password "password"
    When I sign in as "user@test.com/password"
    And I visit the profile of the user with email "user@test.com"
    Then I should see "Test User"
    And I should not see a button with "Request friendship"
    
  Scenario: View a user's profile that I have requested friendship with
    Given a user with an email "foo@bar.com" and name "Jeff S"
    And I am a user with an email "user@test.com" and password "password"
    When I sign in as "user@test.com/password"
    And I request friendship with the user
    And I visit the profile of the user with email "foo@bar.com"
    Then I should not see a button with "Request friendship"
    And I should see "Friendship request pending"
  
  Scenario: View a user's profile that has requested friendship with me
    Given I am a user with an email "user@test.com" and password "password"
    And I am friended by a user with an email "foo@bar.com" and name "Jeff S"
    When I sign in as "user@test.com/password"
    And I visit the profile of the user with email "foo@bar.com"
    Then I should not see a button with "Request friendship"
    And I should see "Jeff S requested friendship"
    And I should see a button with "Accept"
    And I should see a button with "Ignore"