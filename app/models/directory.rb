# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# A directory in Prospero library
#
# See also LibraryFile
class Directory < LibraryFile
  def documents
    Document.find_by_sql(documents_sql)
  end

  private

  # Uses PostgreSQL recursive queries
  # See https://www.postgresql.org/docs/current/queries-with.html#QUERIES-WITH-SELECT
  def documents_sql
    columns = self.class.column_names
    table_name = self.class.table_name
    "WITH RECURSIVE tree(#{columns.join(',')}) AS (
        SELECT #{columns.join(',')} FROM #{table_name}
          WHERE parent_id = '#{id}'
      UNION ALL
        SELECT #{columns.map { |col| 'children.' + col }.join(',')}
          FROM #{table_name} children, tree
          WHERE children.parent_id = tree.id
    ) SELECT * FROM tree WHERE tree.type = '#{Document}'"
  end
end
