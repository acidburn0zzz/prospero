# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Base mailer class
#
# see https://guides.rubyonrails.org/action_mailer_basics.html
class ApplicationMailer < ActionMailer::Base
  default from: APP_CONFIG['mailer']['sender']
  layout 'mailer'
end
