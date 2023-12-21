require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with invalid parameters' do
      let(:invalid_params) { { user: { email: '', password: '' } } }
      let(:admin_user) { User.create!(email: 'test@test.com', password: '1234', role: 1) }
      let(:token) { JWT.encode({ user_id: admin_user.id, exp: 24.hours.from_now.to_i }, 'SECRET_KEY_BASE') } 
    
      before do
        request.headers['Authorization'] = "Bearer #{token}"
      end

      it 'returns a bad request error' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq(["Password can't be blank", "Email can't be blank"])
      end
    end
  end
end