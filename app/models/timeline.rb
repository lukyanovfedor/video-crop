class Timeline
  attr_reader :from, :to

  class << self
    def demongoize(obj)
      case obj
        when ActionController::Parameters
          Timeline.new(obj[:from], obj[:to])
        when Hash
          Timeline.new(obj[:from], obj[:to])
        when Array
          Timeline.new(obj[0], obj[1])
        else
          obj
      end
    end

    def mongoize(obj)
      case obj
        when ActionController::Parameters
          Timeline.new(obj[:from], obj[:to]).mongoize
        when Hash
          Timeline.new(obj[:from], obj[:to]).mongoize
        when Timeline
          obj.mongoize
        when Array
          Timeline.new(obj[0], obj[1]).mongoize
        else
          obj
      end
    end

    alias_method :evolve, :mongoize
  end

  def initialize(from, to)
    @from, @to = from.to_i, to.to_i
  end

  def duration
    @to - @from
  end

  def start_time
    convert_seconds @from
  end

  def end_time
    convert_seconds @to
  end

  def duration_time
    convert_seconds duration
  end

  def mongoize
    [ @from, @to ]
  end

  private

    def convert_seconds(value)
      Time.at(value).gmtime.strftime('%H:%M:%S')
    end

end