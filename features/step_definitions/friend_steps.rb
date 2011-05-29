Given /^I am friended by a user with an email "([^"]*)" and name "([^"]*)"$/ do |email, name|
  Given %{a user with an email "#{email}" and name "#{name}"}
  When %{I sign in as "#{email}/password"}
  And %{I visit the profile of the user with email "#{@current_user.email}"}
  And %{I press "Request friendship"}
end

When /^I request friendship with the user$/ do 
  When %{I visit the profile of the user with email "#{@user.email}"}
  And %{I press "Request friendship"}
end
