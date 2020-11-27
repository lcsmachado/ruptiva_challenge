require 'rails_helper'

RSpec.describe 'auth/sign_in', type: :request do
  context 'as :admin' do
    let!(:user) { create(:user, email: 'admin@example.com', password: '123456') }

    include_examples 'sign in', 'admin@example.com', '123456'
  end
  
  context 'as :client' do
    let!(:user) { create(:user, role: :client, email: 'client@example.com', password: '123456') }

    include_examples 'sign in', 'client@example.com', '123456'
  end
end