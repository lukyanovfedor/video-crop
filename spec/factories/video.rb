FactoryGirl.define do
  factory :video do
    timeline
    file do
      path = File.join(Rails.root, '/spec/fixtures/video/sonic_reducer.mp4')
      Rack::Test::UploadedFile.new(File.open(path))
    end
  end
end
