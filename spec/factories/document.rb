# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Document objects factory for testing
#
# See https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#defining-factories
FactoryBot.define do
  factory :document, class: Document, parent: :library_file do
    body { Faker::Lorem.paragraphs.join('\n') }
  end
end
