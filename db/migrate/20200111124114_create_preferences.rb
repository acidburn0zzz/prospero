# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant
class CreatePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences, id: :uuid do |t|
      t.timestamps    null: false
      t.text :locale, null: false
    end
    add_column :users, :preference_id, :text, null: false
  end
end
