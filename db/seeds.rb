# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

User.create!(
  email: 'user@email.net',
  password: 'password',
  confirmed_at: Time.now
)
