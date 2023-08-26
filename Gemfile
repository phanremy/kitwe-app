source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.0.3'

# Use Acts as votable for upvotes
gem 'acts_as_votable'
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
# Use Cancan for authorization
gem 'cancancan'
# Use Cloudinary for image upload
gem 'cloudinary'
# Use Devise for permission
gem 'devise'
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'
# Use Importmap Rails to replace webpacker
gem 'importmap-rails'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'
# Use jwt to create tokens
gem 'jwt', '~> 2.2'
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'
# Use Pagy for paginating with infinite scrolling options
gem 'pagy'
# Use Paper Trail for logging modifications
# gem 'paper_trail'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.3'
# Use for Rails Locale
gem 'rails-i18n', '~> 7.0.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Sass to process CSS
# gem 'sassc-rails'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'
# Use Tailwindcss-Rails to use Tailwind
gem 'tailwindcss-rails', '~> 2.0'
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # Use bullet for detecting N+1 query
  gem 'bullet'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # Use Faker for seeding fake info
  gem 'faker'
end

group :development do
  # Use Byebug
  gem 'byebug'
  # Use dotenv-rails to manage credentials
  gem 'dotenv-rails'
  # Use figaro to manage credentials
  gem 'figaro'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem 'rack-mini-profiler'
  # Use Rubocop Rails with yml ignoring comments
  gem 'rubocop-rails'
  # Use Solargraph for Ruby code intelligence [https://solargraph.org]
  gem 'solargraph', require: false
  gem 'solargraph-rails', require: false
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
