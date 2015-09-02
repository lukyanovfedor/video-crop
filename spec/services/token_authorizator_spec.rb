require 'rails_helper'

RSpec.describe TokenAuthorizator do
  let!(:user) { FactoryGirl.create :user }

  describe '.create_from_request' do
    let(:req) { double }

    before do
      allow(ActionController::HttpAuthentication::Token).to(
        receive(:token_and_options) { [user.api_key.token, {}] }
      )
    end

    it 'expect to return new TokenAuthorizator' do
      expect(TokenAuthorizator).to receive(:new).with(user.api_key.token, {})
      TokenAuthorizator.create_from_request(req)
    end
  end

  describe '#authorize' do
    let(:token) { user.api_key.token }
    let(:authorizator) { TokenAuthorizator.new(token, {}) }

    it 'returns false when token nil' do
      authorizator.instance_variable_set(:@token, nil)
      expect(authorizator.authorize).to be_falsey
    end

    it 'returns user if user.api_key.token matched to token' do
      expect(authorizator.authorize).to eq user
    end

    it 'returns false if no token matched' do
      User.destroy_all
      expect(authorizator.authorize).to be_falsey
    end
  end
end