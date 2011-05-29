Feature: Edit User
  
  As a registered user
  I want to edit my account information
  So I can update my email and password

  Scenario: I sign in and change my email address
    Given I am a user with an email "user@test.com" and password "password"
    When I sign in as "user@test.com/password"
    Then I should be signed in
    When I follow "Edit account"
    And I fill in "Email" with "foo@bar.com"
    And I fill in "Current password" with "password"
    And I press "Update"
    And I sign out
    And I sign in as "foo@bar.com/password"
    Then I should be signed in
    
  Scenario: I sign in and change my password
    Given I am a user with an email "user@test.com" and password "password"
    When I sign in as "user@test.com/password"
    Then I should be signed in
    When I follow "Edit account"
    And I fill in "Password" with "newpassword"
    And I fill in "Password confirmation" with "newpassword"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I sign out
    When I sign in as "user@test.com/newpassword"
    Then I should be signed in
    
  Scenario: I sign in and change my name
    Given I am a user with an email "user@test.com" and password "password"
    When I sign in as "user@test.com/password"
    Then I should be signed in
    When I follow "Edit account"
    And I fill in "Name" with "Joe Jack"
    And I fill in "Current password" with "password"
    And I press "Update"
    And I go to the home page
    Then I should see "Joe Jack"