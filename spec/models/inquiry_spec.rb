require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  subject(:inquiry) { FactoryGirl.create :inquiry }

  describe 'Associations' do
    it { expect(inquiry).to belong_to(:user) }
    it { expect(inquiry).to embed_one(:video) }
  end

  describe 'Validation' do
    it { expect(inquiry).to validate_presence_of(:state) }
    it { expect(inquiry).to validate_presence_of(:video) }
    it { expect(inquiry).to validate_inclusion_of(:state).to_allow(:failed, :scheduled, :processing, :done) }
  end

  describe 'After create' do
    before { allow(VideoCropJob).to receive(:perform_later) }

    it 'expect to receive crop' do
      inq = FactoryGirl.build :inquiry
      expect(inq).to receive(:crop_video)
      inq.save
    end
  end

  describe '.find_by_video' do
    context 'video with id exist' do
      it 'expect to return inquiru' do
        expect(Inquiry.find_by_video(inquiry.video.id)).to eq inquiry
      end
    end

    context 'video with id not exist' do
      it 'expect to return nil' do
        Inquiry.destroy_all
        expect(Inquiry.find_by_video('yoyooyyoyoo')).to be_nil
      end
    end
  end

  describe 'States' do
    context 'scheduled' do
      it 'expect to be initial state' do
        expect(inquiry).to be_scheduled
      end

      it 'expect to allow transition to processing' do
        inquiry.process!
        expect(inquiry).to be_processing
      end

      it 'expect not to allow transition to failed' do
        inquiry.fail!
        expect(inquiry).not_to be_failed
      end

      it 'expect not to allow transition to done' do
        inquiry.done!
        expect(inquiry).not_to be_done
      end
    end

    context 'processing' do
      before { inquiry.process! }

      it 'expect to allow transition to done' do
        inquiry.done!
        expect(inquiry).to be_done
      end

      it 'expect to allow transition to failed' do
        inquiry.fail!
        expect(inquiry).to be_failed
      end

      it 'expect not to allow transition to scheduled' do
        inquiry.restart!
        expect(inquiry).not_to be_scheduled
      end
    end

    context 'done' do
      before { inquiry.process!; inquiry.done! }

      it 'expect not to allow transition to scheduled' do
        inquiry.restart!
        expect(inquiry).not_to be_scheduled
      end

      it 'expect not to allow transition to failed' do
        inquiry.fail!
        expect(inquiry).not_to be_failed
      end

      it 'expect not to allow transition to processing' do
        inquiry.process!
        expect(inquiry).not_to be_processing
      end
    end

    context 'failed' do
      before { inquiry.process!; inquiry.fail! }

      it 'expect to allow transition to scheduled' do
        inquiry.restart!
        expect(inquiry).to be_scheduled
      end

      it 'expect not to allow transition to processing' do
        inquiry.process!
        expect(inquiry).not_to be_processing
      end

      it 'expect not to allow transition to done' do
        inquiry.done!
        expect(inquiry).not_to be_done
      end
    end
  end

  describe '#crop_video' do
    it 'expect to receive recreate_versions! with :cropped for video' do
      allow(inquiry).to receive_message_chain(:video, :file, :ready_for_crop, :recreate_versions!).with(:cropped) { true }
      expect(inquiry).to receive_message_chain(:video, :file, :ready_for_crop, :recreate_versions!).with(:cropped)
      inquiry.crop_video
    end
  end

end
