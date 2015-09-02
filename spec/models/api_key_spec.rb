require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  subject(:api_key) { FactoryGirl.create(:user).api_key }

  describe 'Associations' do
    it { expect(api_key).to be_embedded_in(:user) }
  end

  describe 'Validations' do
    it { expect(api_key).to validate_presence_of(:token) }
  end

  describe 'Before validation' do
    describe '#sets_token' do
      context 'token already set' do
        it 'expect not to change token' do
          token = api_key.token
          api_key.save
          expect(api_key.token).to eq token
        end

        it 'expect to set token if token not exist' do
          api_key.update(token: nil)
          expect(api_key.token).not_to be_nil
        end
      end
    end
  end

  describe '.generate_token' do
    it 'generates string token' do
      expect(ApiKey.generate_token).to be_a String
    end

    it 'generates uniq token' do
      token = ApiKey.generate_token
      expect { ApiKey.find_by(token: token) }.to(
        raise_error(Mongoid::Errors::DocumentNotFound)
      )
    end
  end
end
