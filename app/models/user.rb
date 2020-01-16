# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# The authentication model
#
# See https://github.com/plataformatec/devise#configuring-models
class User < ApplicationRecord
  devise(
    # See https://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Registerable
    :registerable,
    # See https://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Validatable
    :validatable,
    # See https://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Confirmable
    :confirmable,
    # See https://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/DatabaseAuthenticatable
    :database_authenticatable,
    # See https://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Recoverable
    :recoverable,
    # See https://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Rememberable
    :rememberable,
    # See https://github.com/plataformatec/devise/wiki/How-To:-Send-devise-emails-in-background-(Resque,-Sidekiq-and-Delayed::Job)#for-devise--211
    :async
  )

  belongs_to :preference, dependent: :destroy

  validates_presence_of :full_name

  after_initialize :init_preference, if: :new_record?

  private

  def init_preference
    self.preference = Preference.new
  end
end
