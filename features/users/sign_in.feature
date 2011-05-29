Feature: Sign in

  In order to gain access to protected areas of the site
  A user
  Should be able to sign in with an existing account
  
  Scenario: User is not signed up
    Given that I am signed out
    And no user exists with an email of "user@test.com"
    When I go to the sign in page
    And I sign in as "user@test.com/password"
    Then I should see "Invalid email or password"
    And I go to the home page
    And I should be signed out
    
  Scenario: User enters wrong password
    Given that I am signed out
    And I am a user with an email "user@test.com" and password "password"
    When I go to the sign in page
    And I sign in as "user@test.com/wrongpass"
    Then I should see "Invalid email or password"
    And I go to the home page
    And I should be signed out

  Scenario: User signs in successfully
    Given that I am signed out 
    And I am a user with an email "user@test.com" and password "password"
    When I go to the sign in page
    And I sign in as "user@test.com/password"
    Then I should see "Signed in successfully"
    And I should be signed in
    When I return next time
    Then I should be signed in
