require 'rails_helper'

RSpec.describe 'auth/sign_up', type: :request do
  context 'POST /users' do
    let(:url) { '/auth' }
    
    context 'with valid params' do
      let(:user_params) { { user: attributes_for(:user) }.to_json }

      it 'adds a new user' do
        expect do
          post url, params: user_params
        end.to change(User, :count).by(1)
      end

      it 'returns last added user' do
        post url, params: user_params
        expected_user = User.last.as_json(only: %i[id first_name last_name email role])
        expect(body_json['user']).to eq expected_user
      end

      it 'return success status' do
        post url, params: user_params
        expect(response).to have_http_status(:success)
      end
    end
    
    context 'with invalid params' do
      let(:user_params) { { user: attributes_for(:user, first_name: nil) }.to_json }

      it 'does not add a new user' do
        expect do
          post url, params: user_params
        end.to_not change(User, :count)
      end

      it 'returns error messages' do
        post url, params: user_params
        expect(body_json['errors']['fields']).to have_key('first_name')
      end

      it 'returns unprocessable_entity status' do
        post url, params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end    
    end
  end
end