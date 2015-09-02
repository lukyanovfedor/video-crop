class VideoCropJob < ActiveJob::Base
  queue_as :default

  def perform(filename, video_id)
    inquiry = Inquiry.find_by_video(BSON::ObjectId.from_string(video_id))

    inquiry.process!
    unless inquiry.processing?
      return
    end

    if VideoCropper.new(filename, inquiry.video).crop
      inquiry.done!
    else
      inquiry.fail!
    end
  end
end
