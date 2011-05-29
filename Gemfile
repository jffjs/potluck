source 'http://rubygems.org'

gem 'rails', '3.1.0.rc1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'devise', :git => 'https://github.com/plataformatec/devise.git'
gem 'haml'

# Asset template engines
gem 'sass'
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'factory_girl_rails'
end

group :test, :development do
  gem 'capybara'
  gem 'cucumber-rails'
  gem 'rspec-rails', '2.6.1.beta1' # to work with new 0.9.0 rake
  gem 'database_cleaner'
  gem 'ZenTest'
  gem 'autotest-rails'
  gem 'autotest-growl'
  gem 'autotest-fsevent'
end