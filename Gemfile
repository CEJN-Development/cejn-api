source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.3'

# https://github.com/rails/rails/tree/main/actionpack
gem 'actionpack', '>= 6.1.4.7'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# https://github.com/puma/puma
gem 'puma', '~> 5.6'

# https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.12'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# https://github.com/heartcombo/devise
gem 'devise'

# https://github.com/waiting-for-dev/devise-jwt
gem 'devise-jwt'

# https://github.com/davidwparker/devise-jwt-cookie
gem 'devise-jwt-cookie', github: 'davidwparker/devise-jwt-cookie'

# https://github.com/bkeepers/dotenv/
gem 'dotenv-rails'

# https://github.com/cyu/rack-cors
gem 'rack-cors'

# https://github.com/cloudinary/cloudinary_gem
gem 'cloudinary'

# https://github.com/ilyakatz/data-migrate
gem 'data_migrate'

# https://github.com/mperham/sidekiq
gem 'sidekiq'

# https://github.com/sferik/twitter
gem 'twitter', '~> 7.0'

group :development, :test do
  # https://github.com/deivid-rodriguez/byebug
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # https://github.com/teamcapybara/capybara
  gem 'capybara'

  # https://github.com/DatabaseCleaner/database_cleaner
  gem 'database_cleaner'

  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails'

  # https://github.com/pry/pry
  gem 'pry'

  # https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails'

  # https://github.com/faker-ruby/faker
  gem 'faker'

  # https://github.com/SeleniumHQ/selenium/tree/trunk/rb
  gem 'selenium-webdriver'

  # https://github.com/titusfortner/webdrivers
  gem 'webdrivers'
end

group :development do
  # https://github.com/guard/listen
  gem 'listen', '~> 3.3'

  # https://github.com/rails/spring
  gem 'spring'

  # https://github.com/ctran/annotate_models
  gem 'annotate'

  # https://github.com/ryanb/letter_opener
  gem 'letter_opener'
end

group :test do
  # https://github.com/DatabaseCleaner/database_cleaner
  gem 'database_cleaner-active_record'

  # https://github.com/colszqowka/simplecov
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
