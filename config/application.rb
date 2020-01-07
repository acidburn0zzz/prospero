# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

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
config_file = ERB.new(File.new("#{__dir__}/config.yml").read).result

APP_CONFIG = YAML.safe_load(config_file, aliases: true)[Rails.env]

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Prospero
  # Prospero Rails application
  #
  # See https://api.rubyonrails.org/classes/Rails/Application.html
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Use error routes to handle exceptions
    #
    # See routes.rb
    config.exceptions_app = routes
  end
end
