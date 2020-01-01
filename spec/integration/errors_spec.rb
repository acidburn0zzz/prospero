# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Errors integration tests
describe 'Errors' do
  context 'Not found' do
    %i[get post put delete].each do |http_method|
      context http_method do
        context 'HTML response' do
          before { method(http_method).call('/error/404') }

          it { expect(response).to have_http_status(:not_found) }
        end

        context 'JSON response' do
          before do
            method(http_method).call(
              '/error/404', headers: {
                'Accept' => 'application/json'
              }
            )
          end

          it { expect(response).to have_http_status(:not_found) }
          it 'is expected to respond with error message' do
            expect(json(response.body)['error']).to(
              eq(translate('errors.messages.not_found'))
            )
          end
        end
      end
    end
  end

  context 'Server error' do
    %i[get post put delete].each do |http_method|
      context http_method do
        context 'HTML response' do
          before { method(http_method).call('/error/500') }

          it { expect(response).to have_http_status(:server_error) }
        end

        context 'JSON response' do
          before do
            method(http_method).call(
              '/error/500', headers: {
                'Accept' => 'application/json'
              }
            )
          end

          it { expect(response).to have_http_status(:server_error) }
          it 'is expected to respond with error message' do
            expect(json(response.body)['error']).to(
              eq(translate('errors.messages.server_error'))
            )
          end
        end
      end
    end
  end
end
