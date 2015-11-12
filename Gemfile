source "https://rubygems.org"

ruby "1.9.3"

gem "rails", "3.2.21"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "omniauth-github-team-member"
gem "state_machine"
gem "httparty"
gem "simple_uuid"
gem "mail_view"
gem "pg"
gem "mailchimp-api"
gem "activeadmin"
gem "rails_12factor"

group :assets do
  gem "coffee-rails", '~> 3.2.2'
  gem "sass-rails", '~> 3.2.6'
  gem "neat"
  gem "compass-rails"
  gem "uglifier", '>= 1.0.3'
end

group :development, :test do
  gem "dotenv-rails"
  gem "minitest-rails"
  gem "pry"
  gem "sqlite3"
end

group :test do
  gem "guard-minitest"
  gem "minitest-capybara"
  gem "machinist"
  gem "faker"
  gem "webmock"
  gem "vcr"
  gem "mocha", require: false
  gem "database_cleaner"
  gem "terminal-notifier-guard"
end
