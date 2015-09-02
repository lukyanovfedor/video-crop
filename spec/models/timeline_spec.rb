require 'rails_helper'

RSpec.describe Timeline do
  subject(:timeline) { FactoryGirl.create :timeline, from: 100, to: 150 }

  describe '.mongoize' do
    context 'Hash' do
      it 'expect to receive #mongoize' do
        expect_any_instance_of(Timeline).to receive(:mongoize)
        Timeline.mongoize(from: 0, to: 10)
      end
    end

    context 'ActionController::Parameters' do
      it 'expect to receive #mongoize' do
        prms = ActionController::Parameters.new(from: 10, to: 20)
        expect_any_instance_of(Timeline).to receive(:mongoize)
        Timeline.mongoize(prms)
      end
    end

    context 'Array' do
      it 'expect to receive #mongoize' do
        expect_any_instance_of(Timeline).to receive(:mongoize)
        Timeline.mongoize([0, 10])
      end
    end

    context 'else' do
      it 'expect to return else' do
        expect(Timeline.mongoize('yoyo')).to eq 'yoyo'
      end
    end
  end

  describe '.demongoize' do
    context 'Hash' do
      it 'expect to return new Timeline' do
        expect(Timeline.demongoize(from: 10, to: 20)).to be_a Timeline
      end
    end

    context 'ActionController::Parameters' do
      it 'expect to return new Timeline' do
        prms = ActionController::Parameters.new(from: 10, to: 20)
        expect(Timeline.demongoize(prms)).to be_a Timeline
      end
    end

    context 'Array' do
      it 'expect to return new Timeline' do
        expect(Timeline.demongoize([10, 20])).to be_a Timeline
      end
    end

    context 'else' do
      it 'expect to return else' do
        expect(Timeline.demongoize('yoyo')).to eq 'yoyo'
      end
    end
  end

  describe '#duration' do
    it 'expect to return from - to' do
      expect(timeline.duration).to eq 50
    end
  end

  describe '#mongoize' do
    it { expect(timeline.mongoize).to be_a Array }
    it { expect(timeline.mongoize.size).to eq 2 }
    it { expect(timeline.mongoize[0]).to eq timeline.from }
    it { expect(timeline.mongoize[1]).to eq timeline.to }
  end

  describe '#start_time' do
    it 'expect to return #from in format %H:%M:%S' do
      expect(timeline.start_time).to eq '00:01:40'
    end
  end

  describe '#end_time' do
    it 'expect to return #to in format %H:%M:%S' do
      expect(timeline.end_time).to eq '00:02:30'
    end
  end

  describe '#duration_time' do
    it 'expect to return #duration in format %H:%M:%S' do
      expect(timeline.duration_time).to eq '00:00:50'
    end
  end
end