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

Factory.define :recipe do |r|
  r.name "Stew"
  r.description "Beefy and good"
  r.preparation "Throw it in a pot"
end

Factory.define :group do |g|
  g.name "Family"
  g.description "Family recipes!"
end
