require 'rails_helper'

RSpec.describe VideoCropper do
  let!(:inquiry) { FactoryGirl.create :inquiry }
  let!(:video) { inquiry.video }
  let!(:filename) { inquiry.video.file.filename }
  let!(:ffmpeg) { FFMPEG::Movie.new video.file.path }
  let(:cropper) { VideoCropper.new(filename, video) }

  before { allow(FFMPEG::Movie).to receive(:new) { ffmpeg } }

  describe '#crop' do
    context 'video invalid' do
      before { allow(ffmpeg).to receive(:valid?) { false } }

      it { expect(cropper.crop).to be_falsey }
    end

    context 'video valid' do
      before { allow(ffmpeg).to receive(:valid?) { true } }

      it 'expect to receive transcode' do
        expect(ffmpeg).to receive(:transcode)
        cropper.crop
      end

      it 'expect to return true if transcode successful' do
        allow(ffmpeg).to receive(:transcode) { true }
        expect(cropper.crop).to be_truthy
      end

      it 'expect to return true if transcode failed' do
        allow(ffmpeg).to receive(:transcode).and_raise('boom')
        expect(cropper.crop).to be_falsey
      end
    end
  end

end