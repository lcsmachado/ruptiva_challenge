require 'rails_helper'

RSpec.describe 'auth/sign_up', type: :request do
  context 'POST /users' do
    let(:url) { '/auth' }

    context 'with valid params' do
      let(:user_params) { attributes_for(:user, role: :client).to_json }
      it 'adds new User' do
        expect {
          post url, headers: default_header, params: user_params
        }.to change(User, :count).by(1)
      end

      it 'add User as :client' do
        post url, headers: default_header, params: user_params
        expect(User.last.role).to eq 'client'
      end

      it 'returns :ok status' do
        post url, headers: default_header, params: user_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:user_invalid_params) { attributes_for(:user, email: nil).to_json }

      it 'does not add a new User' do
        expect {
          post url, headers: default_header, params: user_invalid_params
        }.to_not change(User, :count)
      end

      it 'return :unprocessable_entity status' do
        post url, headers: default_header, params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
