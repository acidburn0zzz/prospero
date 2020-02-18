# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant
class CreateLibraryFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :library_files, id: :uuid do |t|
      t.timestamps            null: false
      t.text       :name,     null: false
      t.text       :type,     null: false
      t.text       :body
      t.uuid       :parent_id
    end
    add_index :library_files, :type
    add_index :library_files, %i[parent_id name], unique: true
  end
end
