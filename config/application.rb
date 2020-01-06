require_relative 'boot'

require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
require 'active_job/railtie'
# require 'action_cable/engine'
# require 'action_mailbox/engine'
# require 'action_text/engine'
require 'rails/test_unit/railtie'
require 'sprockets/railtie'

# Load application configuration
config_file = File.new("#{__dir__}/config.yml")
APP_CONFIG = YAML.load(ERB.new(config_file.read).result)[Rails.env]

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Prospero
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Use error routes to handle exceptions
    #
    # See routes.rb
    config.exceptions_app = self.routes
  end
end
