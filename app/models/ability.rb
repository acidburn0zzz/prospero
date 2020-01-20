# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Authorization rights management
#
# See https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil? # Not logged user
      can :create, User
      return
    end

    can :read, User
    can %i[update destroy], User, id: user.id

    can %i[read update], Preference, id: user.preference_id
  end
end
