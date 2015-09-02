require 'rails_helper'

RSpec.describe Video, type: :model do
  let!(:inquiry) { FactoryGirl.create :inquiry }
  subject(:video) { inquiry.video }

  describe 'Validation' do
    it { expect(video).to validate_presence_of(:file) }
    it { expect(video).to validate_presence_of(:timeline) }

    it "expect not to be valid with video not in format #{VideoUploader::VIDEO_WHITELIST.join(', ')}" do
      bad_video = File.join(Rails.root, '/spec/fixtures/video/cat.mov')
      bad_video = Rack::Test::UploadedFile.new(File.open(bad_video))

      video.update(file: bad_video)

      expect(video).not_to be_valid
    end

    it 'expect not to be valid with start time > end time' do
      video.update(timeline: [100, 10])

      expect(video).not_to be_valid
    end

    it 'expect not to be valid with end time equal zero' do
      video.update(timeline: [100, 0])

      expect(video).not_to be_valid
    end

    it 'expect not to be valid with start time less zero' do
      video.update(timeline: [-100, 10])

      expect(video).not_to be_valid
    end

    it 'expect not to be valid with start greter video duration' do
      video.update(timeline: [1000000, 1000010])

      expect(video).not_to be_valid
    end
  end

  describe 'Associations' do
    it { expect(video).to be_embedded_in(:inquiry) }
  end
end
