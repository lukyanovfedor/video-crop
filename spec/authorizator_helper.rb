def allow_access_for(user)
  authorizator = TokenAuthorizator.new(user.api_key.token, {})
  allow(TokenAuthorizator).to receive(:create_from_request) { authorizator }
  authorizator
end