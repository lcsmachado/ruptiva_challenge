require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  context 'GET /users' do
    let(:url) { '/users' }
    let(:users) { create_list(:user, 5) }

    it 'returns all users' do
      auth = user.create_new_auth_token
      header = auth.merge({ 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
      get url, headers: header
      expect(response.body).to contain_exactly(*users.as_json(only: %i[id first_name last_name email role]))
    end

    it 'returns success status' do
      auth = user.create_new_auth_token
      header = auth.merge({ 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
      get url, headers: header
      expect(response).to have_http_status(:success)  
    end
  end
  
end
