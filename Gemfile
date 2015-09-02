source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'jbuilder', '~> 2.0'
gem 'mongoid', '~> 5.0.0.beta'
gem 'sidekiq'
gem 'carrierwave'
gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'aasm'
gem 'streamio-ffmpeg'
gem 'cancancan', '~> 1.10'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :doc do
  gem 'sdoc', '~> 0.4.0', group: :doc
end

group :development do
  gem 'byebug'
end

group :development, :test do
  gem 'faker'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'mongoid-rspec', '2.3.0.rc0'
end

group :test do
  gem 'database_cleaner', git: 'https://github.com/geerzo/database_cleaner.git'
  gem 'fuubar'
  gem 'codeclimate-test-reporter'
end
