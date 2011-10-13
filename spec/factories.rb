FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@email.com"
  end

  factory :recipe do
    name "Stew"
    description "Beefy and good"
    preparation "Throw it in a pot"
    privacy 0
  end

  factory :user do
    name "John Doe"
    email { FactoryGirl.generate(:email) }
    password "password"
    password_confirmation "password"
  end

  factory :friend, :class => User do
    name "Jane Doe"
    email { FactoryGirl.generate(:email) }
    password "password"
    password_confirmation "password"
  end

  factory :group do
    name "Family"
    description "Family recipes!"
  end
end
