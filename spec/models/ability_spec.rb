require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }
  let(:user) { nil }

  describe 'user is authorized' do
    let(:user) { FactoryGirl.create :user }
    let(:inquiry) { FactoryGirl.create :inquiry }

    it { expect(ability).to be_able_to(:create, Inquiry) }
    it { expect(ability).to be_able_to(:read, Inquiry.new(user: user)) }
    it { expect(ability).to be_able_to(:restart, Inquiry.new(user: user)) }
  end
end