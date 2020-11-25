require 'rails_helper'

RSpec.describe "Users as :admin", type: :request do
  let!(:user) { create(:user) }
  context 'GET /users' do
    let(:url) { '/users' }
    let(:users) { create_list(:user, 5) }

    it 'returns all users' do
      users.push(user)
      get url, headers: auth_header(user)
      expect(body_json['users']).to contain_exactly(*users.as_json(only: %i[id first_name last_name email role]))
    end

    it 'returns success status' do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:success)  
    end
  end
  
  context 'POST /users' do
    let(:url) { '/users' }
    
    context 'with valid params' do
      let(:user_params) { { user: attributes_for(:user) }.to_json }

      it 'adds a new user' do
        expect do
          post url, headers: auth_header(user), params: user_params
        end.to change(User, :count).by(1)
      end

      it 'returns last added user' do
        post url, headers: auth_header(user), params: user_params
        expected_user = User.last.as_json(only: %i[id first_name last_name email role])
        expect(body_json['user']).to eq expected_user
      end

      it 'return success status' do
        post url, headers: auth_header(user), params: user_params
        expect(response).to have_http_status(:success)
      end
    end
    
    context 'with invalid params' do
      let(:user_params) { { user: attributes_for(:user, first_name: nil) }.to_json }

      it 'does not add a new user' do
        expect do
          post url, headers: auth_header(user), params: user_params
        end.to_not change(User, :count)
      end

      it 'returns error messages' do
        post url, headers: auth_header(user), params: user_params
        expect(body_json['errors']['fields']).to have_key('first_name')
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(user), params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end    
    end
  end

  context 'PATCH /users/:id' do
    let!(:user) { create(:user) }
    let(:url) { "/users/#{user.id}" }

    context 'with valid params' do
      let(:new_name) { 'My New Name' }
      let(:user_update_params) { { user: { first_name: new_name } }.to_json }

      it 'updates user' do
        patch url, headers: auth_header(user), params: user_update_params
        user.reload
        expect(user.first_name).to eq new_name
      end

      it 'returns updates user' do
        patch url, headers: auth_header(user), params: user_update_params
        user.reload
        expected_user = user.as_json(only: %i[id first_name last_name email role])
        expect(body_json['user']).to eq expected_user
      end

      it 'returns success status' do
        patch url, headers: auth_header(user), params: user_update_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:user_update_params) do
        { user: attributes_for(:user, first_name: nil) }.to_json
      end

      it 'does not update user' do
        old_name = user.first_name
        patch url, headers: auth_header(user), params: user_update_params
        user.reload
        expect(user.first_name).to eq old_name
      end

      it 'returns error messages' do
        patch url, headers: auth_header(user), params: user_update_params
        expect(body_json['errors']['fields']).to have_key('first_name')
      end

      it 'returns unprocessable_entity status' do
        patch url, headers: auth_header(user), params: user_update_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'DELETE users/:id' do
    let!(:user_delete) { create(:user) }
    let(:url) { "/users/#{user_delete.id}" }

    it 'deletes user' do
      expect do
        delete url, headers: auth_header(user)
      end.to change(User, :count).by(-1)
    end

    it 'returns no_content status' do
      delete url, headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

    it 'does not have any body content' do
      delete url, headers: auth_header(user)
      expect(body_json).to_not be_present
    end
  end
end
