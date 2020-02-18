# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Document helpers for tests
module Support
  module Document
    def random_document_name
      Faker::Lorem.sentence
    end

    def random_document_body
      Faker::Lorem.paragraph
    end
  end
end

RSpec.configure do |config|
  config.include Support::Document
end
