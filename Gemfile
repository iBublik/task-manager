source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Testing environment
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'launchy'
end

group :test do
  gem 'shoulda-matchers', '~> 3.0'
  gem 'rspec-its'
  gem 'simplecov', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  gem 'byebug'

  # Generating test data
  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Better error page for Rack apps
  gem 'better_errors'
  gem 'binding_of_caller'

  # Spring speeds up development by keeping
  # your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'

  # Static code analyzer
  gem 'rubocop', require: false

  # Git pre-commit hooks
  gem 'overcommit', require: false

  # Skip assets log
  gem 'quiet_assets'
end

gem 'bootstrap-sass'

# Use slim as a template markup language
gem 'slim-rails'

# Authorization
gem 'pundit'

# Internationalization gems
gem 'rails-i18n' # Global localization rules

# Form helpers
gem 'simple_form'

# File upload
gem 'carrierwave'
gem 'mini_magick'

# Pagination
gem 'kaminari'
gem 'bootstrap-kaminari-views'

# Simplify CRUD controllers
gem 'responders'

# State machine
gem 'workflow'
