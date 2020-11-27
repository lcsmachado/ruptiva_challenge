require 'rails_helper'

RSpec.describe 'auth/sign_out', type: :request do
  let(:url) { '/auth/sign_out' }
  let!(:user) { create(:user) }

  it "removes a token from User" do
    user_headers = auth_header(user)
    user_token = user_headers['client']
    delete url, headers: user_headers
    user.reload
    expect(user.tokens.keys).to_not include(user_token)
  end

  it "returns :ok status" do
    delete url, headers: auth_header(user)
    expect(response).to have_http_status(:ok)
  end
end