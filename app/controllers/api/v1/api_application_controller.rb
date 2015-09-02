class Api::V1::ApiApplicationController < ActionController::Base
  before_filter :check_authorization_token!

  rescue_from do |ex|
    @exception = InternalServerError.new :unexpected
    @exception.set_backtrace ex.backtrace
    handle_exception
  end

  rescue_from ActionController::RoutingError, Mongoid::Errors::DocumentNotFound do |ex|
    @exception = NotFoundError.new :not_found
    @exception.set_backtrace ex.backtrace
    handle_exception
  end

  rescue_from CanCan::AccessDenied do |ex|
    @exception = ForbiddenError.new :not_allowed
    @exception.set_backtrace ex.backtrace
    handle_exception
  end

  rescue_from AuthorizationError, BadRequestError do |ex|
    @exception = ex
    handle_exception
  end

  def routing_error
    raise ActionController::RoutingError.new params[:path]
  end

  private

    def check_authorization_token!
      authorizator = TokenAuthorizator.create_from_request(request)

      if authorizator.authorize
        @user = authorizator.user
      else
        raise AuthorizationError, :token_unregistered
      end
    end

    def current_user
      @user
    end

    def handle_exception
      log_exception
      render_exception
    end

    def log_exception
      logger.error ''
      logger.error "#{@exception.status} #{@exception.title}"
      logger.error @exception.code
      logger.error @exception.details
      logger.error ''
      @exception.backtrace.each { |l| logger.error l }
      logger.error ''
    end

    def render_exception
      render 'api/v1/errors/show', status: @exception.status
    end

end