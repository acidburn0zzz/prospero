# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

module Devise
  # Failure App that gives a JSON response
  class JsonFailureApp < Devise::FailureApp
    def respond
      self.status = 401 # Unauthorized
      self.content_type = Mime[:json].to_s
      self.response_body = Oj.dump(error: i18n_message)
    end
  end
end
