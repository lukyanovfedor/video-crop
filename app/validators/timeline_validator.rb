class TimelineValidator < ActiveModel::EachValidator

  TO_EQUAL_ZERO = 'End time must be greater then zero'
  FROM_LESS_ZERO = 'Start time must be greater or equal zero'
  FROM_BIGGER_TO = 'Start time must be less then end time'
  TO_BIGGER_DURATION = 'Start time must be less then file duration'

  def validate_each(record, attribute, value)
    unless value.is_a? Timeline
      raise ArgumentError, "Expect value to be Timeline, but got #{value.class}"
    end

    if value.from < 0
      record.errors[attribute] << (options[:message] || FROM_LESS_ZERO)
    end

    if value.to <= 0
      record.errors[attribute] << (options[:message] || TO_EQUAL_ZERO)
    end

    if value.from >= value.to
      record.errors[attribute] << (options[:message] || FROM_BIGGER_TO)
    end

    ffmpeg =
      if record.file.path.nil?
        nil
      else
        FFMPEG::Movie.new record.file.path
      end

    if ffmpeg && ffmpeg.valid? && value.to >= ffmpeg.duration
      record.errors[attribute] << (options[:message] || TO_BIGGER_DURATION)
    end
  end

end