class Api::V1::InquiriesController < Api::V1::ApiApplicationController
  load_and_authorize_resource

  def create
    unless @inquiry.valid?
      raise BadRequestError.new(:invalid_input_data, @inquiry.video)
    end

    @inquiry.save!
  end

  def index
  end

  def restart
    unless @inquiry.failed?
      raise BadRequestError.new(:invalid_restart_status)
    end

    @inquiry.restart!
    @inquiry.crop_video

    render :create
  end

  private

    def create_params
      { video: new_video, user: current_user }
    end

    def timeline_params
      if params[:timeline]
        params.require(:timeline).permit(:from, :to)
      else
        {}
      end
    end

    def new_video
      Video.new(
        file: params[:file],
        timeline: Timeline.new(timeline_params[:from], timeline_params[:to])
      )
    end

end