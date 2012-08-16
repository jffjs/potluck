source 'http://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'devise'

# Asset template engines
group :assets do
  gem 'sass-rails', '~> 3.2.0'
  gem 'coffee-rails', '~> 3.2.0'
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'haml-rails'
gem 'twitter-bootstrap-rails'
gem 'simple_form'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'pry-rails'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'factory_girl_rails'
end

group :test, :development do
  gem 'capybara'
  gem 'cucumber-rails'
  gem 'rspec-rails', '~> 2.6'
  gem 'database_cleaner'
  gem 'autotest'
  gem 'autotest-rails'
  gem 'autotest-growl'
  gem 'autotest-fsevent'
end
