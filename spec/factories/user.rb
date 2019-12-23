# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# User objects factory for testing
#
# See https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#defining-factories
FactoryBot.define do
  factory :user do
    trait :confirmed do
      confirmed_at { Faker::Time.backward }
    end
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
