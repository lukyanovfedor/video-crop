require 'rails_helper'

RSpec.describe VideoCropJob, type: :job do
  let!(:inquiry) { FactoryGirl.create :inquiry }
  let!(:cropper) { VideoCropper.new('yo', inquiry.video) }

  before do
    allow(Inquiry).to receive(:find_by_video) { inquiry }
    allow(VideoCropper).to receive(:new) { cropper }
    allow(cropper).to receive(:crop) { true }
  end

  it 'expect to transition inquiry to processing' do
    expect(inquiry).to receive(:process!)
    VideoCropJob.perform_now('yo', inquiry.video.id.to_s)
  end

  it 'expect to transition inquiry to done VideoCropper.crop finished successfully' do
    expect(inquiry).to receive(:done!)
    VideoCropJob.perform_now('yo', inquiry.video.id.to_s)
  end

  it 'expect to transition inquiry to done VideoCropper.crop failed' do
    allow(cropper).to receive(:crop) { false }
    expect(inquiry).to receive(:fail!)
    VideoCropJob.perform_now('yo', inquiry.video.id.to_s)
  end
end
