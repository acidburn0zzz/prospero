source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Rails framework
gem 'rails',                      '~> 6.0.0'
gem 'rails-i18n',                 '~> 6.0.0'
# Bootstrap integration. See https://getbootstrap.com/
gem 'bootstrap',                  '~> 4.0'
# Authorization management
gem 'cancancan',                  '~> 3.0'
# Authentication management
gem 'devise',                     '~> 4.0'
gem 'devise-async',               '~> 1.0'
gem 'devise-i18n',                '~> 1.0'
# Optimzed JSON parser and serializer
gem 'oj',                         '~> 3.0'
# Use PostgreSQL as the database for Active Record
gem 'pg',                         '~> 1.0'
# Use Puma as the app server
gem 'puma',                       '~> 4.1'
# JSON views templating
gem 'rabl',                       '~> 0.14.0'
# React.js integration. See https://reactjs.org/
gem 'react-rails',                '~> 2.0'
# Use SCSS for stylesheets
gem 'sass-rails',                 '~> 6.0'
# Async jobs processing
gem 'sidekiq',                    '~> 6.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks',                 '~> 5.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker',                  '~> 4.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap',                   '~> 1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug',                             platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen',                   '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen',    '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara',                 '>= 2.15'
  gem 'database_cleaner',         '~> 1.0'
  gem 'faker',                    '~> 2.0'
  gem 'factory_bot_rails',        '~> 5.0'
  gem 'rails-controller-testing', '~> 1.0'
  gem 'rspec-rails',              '~> 3.0'
  gem 'selenium-webdriver'
  gem 'shoulda-context',          '~> 1.0'
  gem 'shoulda-matchers',         '~> 4.0'
  gem 'simplecov',                      require: false
  gem 'tzinfo-data',              '~> 1.0' # Required in alpine Linux
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
