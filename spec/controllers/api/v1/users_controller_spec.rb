require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe '#create' do
    it 'expect to render template create' do
      post :create, format: :json
      expect(response).to render_template('create')
    end

    it 'expect to create new User' do
      old = User.count
      post :create, format: :json
      expect(User.count).to eq(old + 1)
    end

    it 'expect to assigns @user' do
      post :create, format: :json
      expect(assigns(:user)).not_to be_nil
    end

    it 'expect to create ApiKey for user' do
      post :create, format: :json
      expect(assigns(:user).api_key).not_to be_nil
    end

    it 'expect to return 200 http status' do
      expect(response).to have_http_status(200)
      post :create, format: :json
    end
  end
end