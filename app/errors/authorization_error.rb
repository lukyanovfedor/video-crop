class AuthorizationError < ApplicationError

  STATUS = 401

  DETAILS = {
    token_unregistered: 'The key is invalid or not registered in the system'
  }

end