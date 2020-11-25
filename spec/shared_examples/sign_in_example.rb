shared_examples 'sign in' do |email, password|
  let(:url) { '/auth/sign_in' }

  context 'when :email and :password are right' do
    it 'returns user token on header' do
      post url, params: { email: email, password: password }
      sing_in_headers = %w[access-token token-type client expiry uid]
      expect(response.headers).to include(*sing_in_headers)
    end

    it 'returns success status' do
      post url, params: { email: email, password: password }
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when :email or :password are wrong' do
    it 'does not return user token on header' do
      post url, params: { email: '', password: password }
      sing_in_headers = %w[access-token token-type client expiry uid]
      expect(response.headers).to_not include(*sing_in_headers)
    end

    it 'returns unauthenticated status' do
      post url, params: { email: '', password: password }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
