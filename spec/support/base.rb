# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

require 'active_support/concern'

# Base helpers for tests
module Support
  module Base
    extend ActiveSupport::Concern

    def random_name
      Faker::Name.name
    end

    def random_email
      Faker::Internet.email
    end

    def random_password
      Faker::Internet.password
    end

    def random_string
      Faker::String.random
    end

    def random_token
      Faker::Internet.password
    end

    def random_time(args = nil)
      Faker::Time.between(args)
    end

    def translate(key, args = nil)
      I18n.translate(key, args)
    end

    def json(string)
      Oj.load(string)
    end
  end
end

RSpec.configure do |config|
  config.include Support::Base
end
