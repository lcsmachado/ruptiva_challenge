require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  context 'GET /users' do
    let(:url) { '/users' }
    let(:users) { create_list(:user, 5) }
    it 'returns all users' do
      new_auth_header = user.create_new_auth_token(user)
      get url, headers: new_auth_header
      expect(response).to have_http_status(200)  
    end
  end
  
end
