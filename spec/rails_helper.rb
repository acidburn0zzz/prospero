# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start('rails')
end

require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'

# RSpec Rails configuration
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # See https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#rspec
  config.include FactoryBot::Syntax::Methods

  # See https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-(and-RSpec)#integration-tests-minitest
  # The example in the documention uses Minitest, but it also works with RSpec
  config.include Devise::Test::IntegrationHelpers, type: :request

  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
