Factory.define :user do |u|
  u.name "John Doe"
  u.email "foo@bar.com"
  u.password "password"
  u.password_confirmation "password"
end

Factory.define :friend, :class => User do |u|
  u.name "Jane Doe"
  u.email "baz@quack.com"
  u.password "password"
  u.password_confirmation "password"
end