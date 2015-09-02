class TokenAuthorizator
  attr_reader :user

  def self.create_from_request(req)
    token_and_opts =
      ActionController::HttpAuthentication::Token.token_and_options(req)

    self.new(*token_and_opts)
  end

  def initialize(token = nil, opt = {})
    @token = token
    @opt = opt
  end

  def authorize
    return false unless @token

    begin
      @user = User.find_by_token @token
    rescue Mongoid::Errors::DocumentNotFound
      false
    end
  end

end