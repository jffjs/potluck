Feature: Sign out
  In order to protect my account
  A user
  Should be able to sign out
  
  Scenario: User signs out
    Given I am a user with an email "user@test.com" and password "password"
    When I sign in as "user@test.com/password"
    Then I should be signed in
    And I sign out
    Then I should see "Signed out"
    When I return next time
    Then I should be signed out
