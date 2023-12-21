require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    let(:user) { User.create!(email: 'test@example.com', password: 'password') }

    context 'with invalid parameters' do
      let(:invalid_params) { { session: { email: '', password: '' } } }

      it 'returns a bad request error' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end