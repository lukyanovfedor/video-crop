class Api::V1::UsersController < Api::V1::ApiApplicationController

  skip_before_filter :check_authorization_token!, only: :create

  def create
    @user = User.new { |u| u.create_api_key }
    @user.save!
  end

end