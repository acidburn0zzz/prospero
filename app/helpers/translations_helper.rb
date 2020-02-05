# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Translations views helper
module TranslationsHelper
  def backend_to_frontend(i18n, key)
    value = i18n.t(key)
    if value.is_a?(Hash)
      return value.each_with_object({}) do |(subkey, _), hash|
        hash[subkey] = backend_to_frontend(i18n, "#{key}.#{subkey}")
      end
    end

    value.gsub('%{', '{{').gsub('}', '}}')
  end
end
