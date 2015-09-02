require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl.create :user }

  describe 'Associations' do
    it { expect(user).to have_many(:inquiries).with_dependent(:destroy) }
    it { expect(user).to embed_one(:api_key) }
  end

  describe '.find_by_token' do
    context 'user with token exist' do
      it 'expect to return user' do
        expect(User.find_by_token(user.api_key.token)).to eq user
      end
    end

    context 'user with token not exist' do
      it 'expect to return nil' do
        User.destroy_all
        expect(User.find_by_token('yoyooyyoyoo')).to be_nil
      end
    end
  end
end
