# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# User preference model tests
describe Preference do
  subject { build(:preference) }

  let(:current_locale) { available_locales.sample }
  before { allow(I18n).to receive(:locale).and_return(current_locale) }

  it 'is expected to validate inclusion of locale in available locales' do
    expect(subject).to(
      validate_inclusion_of(:locale).in_array(available_locales)
    )
  end
  it 'is expected to initialize locale' do
    expect(subject.locale).to eq(current_locale)
  end
end
