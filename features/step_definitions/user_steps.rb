Given /^that I am signed out$/ do
  visit destroy_user_session_path
end

Given /^no user exists with an email of "([^"]*)"$/ do |email|
  User.first(:conditions => {:email => email }).should be_nil
end

Given /^I am a user with an email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  User.create!(:email => email, :password => password,
                                :password_confirmation => password)
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{that I am signed out}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end

When /^I return next time$/ do
  visit root_path
end

Then /^I should be signed out$/ do
  And %{I should see "Sign up"}
  And %{I should see "Log in"}
  And %{I should not see "Log out"}
end

Then /^I should be signed in$/ do
  And %{I should see "Log out"}
  And %{I should not see "Log in"}
end

Then /^I sign out$/ do
  visit destroy_user_session_path
end
