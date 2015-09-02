class VideoCropper

  PUBLIC_PATH = Rails.root.to_s + '/public'

  OPTIONS = {
    video_codec: 'copy',
    audio_codec: 'copy'
  }

  def initialize(filename, video)
    @filename = filename
    @video = video
    @timeline = video.timeline
  end

  def crop
    @ffmpeg = FFMPEG::Movie.new @video.file.path
    unless @ffmpeg.valid?
      return false
    end

    crop_process
  end

  private

    def crop_process
      begin
        @ffmpeg.transcode(output, merge_options)
      rescue => ex
        p ex
        return false
      end

      true
    end

    def merge_options
      OPTIONS.merge(
        custom: "-ss #{@timeline.start_time} -t #{@timeline.duration_time}"
      )
    end

    def store_path(file = nil)
      PUBLIC_PATH + "/#{@video.file.store_path(file)}"
    end

    def output
      "#{store_path}cropped_#{@filename}"
    end

end