When /^I fill out the Recipe form$/ do
  fill_in "Name", :with => "Garfield's Lasagna"
  fill_in "Description", :with => "Garfield's favorite lasagna"
  fill_in "Preparation", :with => "Add this to that and bake for 40 min"
  fill_in "Yields", :with => "8"
  fill_in "Cooking time", :with => "1"
  click_button "Submit"
end

When /^I incorrectly fill out the Recipe form$/ do
  click_button "Submit"
end


Then /^I should see the recipe's name$/ do
  Then %{I should see "Garfield's Lasagna"}
end

Given /^I have added (\d+) recipes$/ do |count|
  count.to_i.times do |n|
    Recipe.create(:name => "Recipe #{n}", :description => "Recipe description",
                  :preparation => "Add x to y", :yields => 4, :cooking_time_hours => 1)
  end
end

Then /^I should see my (\d+) recipes$/ do |count|
  count.to_i.times do |n|
    Then %{I should see "Recipe #{n}"}
  end
end
