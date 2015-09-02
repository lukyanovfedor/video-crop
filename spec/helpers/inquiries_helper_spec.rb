require 'rails_helper'

RSpec.describe InquiriesHelper, type: :helper do

  describe '#video_link' do
    it 'expect to add host and port to link' do
      allow(request).to receive(:protocol) { 'http://' }
      allow(request).to receive(:host_with_port) { 'host:3000' }

      expect(video_link('/yo.jpg')).to eq 'http://host:3000/yo.jpg'
    end
  end

end