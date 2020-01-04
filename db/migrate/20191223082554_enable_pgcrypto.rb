# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Enable extension to provide UUID generation fonction
#
# See https://www.postgresql.org/docs/current/pgcrypto.html
class EnablePgcrypto < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
  end
end
