Given /^I am friended by a user with an email "([^"]*)" and name "([^"]*)"$/ do |email, name|
  Given %{a user with an email "#{email}" and name "#{name}"}
  When %{I sign in as "#{email}/password"}
  And %{I visit the profile of the user with email "#{@current_user.email}"}
  And %{I press "Request friendship"}
end

Given /^I am friends with a user with email "([^"]*)" and name "([^"]*)"$/ do |email, name|
  Given %{I am a user with an email "user@test.com" and password "password"}
  And %{I am friended by a user with an email "foo@bar.com" and name "Joe Friend"}
  When %{I sign in as "user@test.com/password"}
  And %{I press "Accept"}
end

When /^I request friendship with the user$/ do 
  When %{I visit the profile of the user with email "#{@user.email}"}
  And %{I press "Request friendship"}
end
