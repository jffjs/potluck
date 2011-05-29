Feature: New User Sign Up
  
  In order to gain access to protected areas of the site
  A user
  Should be able to sign up
  
  Scenario: User signs up with valid data
    Given that I am signed out
    When I go to the sign up page
    And I fill in "Name" with "Jeff"
    And I fill in "Email" with "user@test.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "Welcome! You have signed up successfully."
    
  Scenario: User signs up with invalid email
    Given that I am signed out
    When I go to the sign up page
    And I fill in "Name" with "Jeff"
    And I fill in "Email" with "invalidemail"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "Email is invalid"
    
  Scenario: User signs up without password
    Given that I am signed out
    When I go to the sign up page
    And I fill in "Name" with "Jeff"
    And I fill in "Email" with "user@test.com"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "Password can't be blank"
    
  Scenario: User signs up without password confirmation
    Given that I am signed out
    When I go to the sign up page
    And I fill in "Name" with "Jeff"
    And I fill in "Email" with "user@test.com"
    And I fill in "Password" with "password"
    And I press "Sign up"
    Then I should see "Password doesn't match confirmation"
    
  Scenario: User signs up without matching password and password confirmation
    Given that I am signed out
    When I go to the sign up page
    And I fill in "Name" with "Jeff"
    And I fill in "Email" with "user@test.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "different"
    And I press "Sign up"
    Then I should see "Password doesn't match confirmation"
    
  Scenario: User signs up without a name
    Given that I am signed out
    When I go to the sign up page
    And I fill in "Email" with "user@test.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "Name can't be blank"