require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do

  describe 'GET #show' do
    context 'when the company does not exist' do
      it 'returns a not found error' do
        get :show, params: { id: 'non-existent-id' }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Couldn\'t find Company with \'id\'=non-existent-id')
      end
    end
  end

  let(:admin_user) { User.create!(email: 'test@test.com', password: '1234', role: 1) }
  let(:token) { JWT.encode({ user_id: admin_user.id, exp: 24.hours.from_now.to_i }, 'SECRET_KEY_BASE') }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'POST #create' do
    context 'when the request is invalid' do
      it 'returns a bad request error' do
        post :create, params: { company: { name: '' } }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('Company name and location both are required')
      end
    end
  end
end