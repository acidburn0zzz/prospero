# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Show translations JSON template
#
# See https://github.com/nesquena/rabl#usage

object @i18n => nil

node :app do |i18n|
  backend_to_frontend(i18n, 'app')
end
node :pages do |i18n|
  backend_to_frontend(i18n, 'pages')
end
node :errors do |i18n|
  backend_to_frontend(i18n, 'errors')
end
node :activerecord do |i18n|
  backend_to_frontend(i18n, 'activerecord')
end
