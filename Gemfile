source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.4", ">= 7.0.4.2"

gem "pg", "~> 1.1"

gem "puma", "~> 5.0"

gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rails-controller-testing'
  gem 'faker'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end


gem 'rswag'
gem 'rubocop', '~> 1.30'
gem 'jwt'
gem 'active_model_serializers'
gem 'rack-cors'
gem 'devise_token_auth'
gem "image_processing", "~> 1.2"
gem 'uuid'
gem 'devise'
gem 'geocoder'




