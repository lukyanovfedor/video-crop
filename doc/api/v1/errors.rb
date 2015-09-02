=begin
  400 Bad Request
  api_version '1'
  formats ['json']
  description
    == Codes
      invalid_input_data: Validation error
      invalid_restart_status: Inquiry can be restarted only with failed status
    == Response example
      {
        "error": {
          "status": 400,
          "title": "BadRequestError",
          "code": "INVALID_INPUT_DATA",
          "details": "Validation error",
          "fields": {
            "file": "File can't be blank"
          }
        }
      }
=end

=begin
  401 Authorization Error
  api_version '1'
  formats ['json']
  description
    == Codes
      token_unregistered: The token is invalid or not registered in the system
    == Response example
      {
        "error": {
          "status": 401,
          "title": "AuthorizationError",
          "code": "TOKEN_UNREGISTERED",
          "details": "The key is invalid or not registered in the system"
        }
      }
=end

=begin
  403 Forbidden Error
  api_version '1'
  formats ['json']
  description
    == Codes
      not_allowed: Not allowed to perform action
    == Response example
      {
        "error": {
          "status": 403,
          "title": "ForbiddenError",
          "code": "NOT_ALLOWED",
          "details": "Not allowed to perform this action"
        }
      }
=end

=begin
  500 Internal Server Error
  api_version '1'
  formats ['json']
  description
    == Codes
      unexpected: Unexpected error while processing request
    == Response example
      {
        "error": {
          "status": 500,
          "title": "InternalServerError",
          "code": "UNEXPECTED",
          "details": "Unexpected error while processing request"
        }
      }
=end

=begin
  404 Not Found Error
  api_version '1'
  formats ['json']
  description
    == Codes
      not_found: Requested resource not found
    == Response example
      {
        "error": {
          "status": 404,
          "title": "NotFoundError",
          "code": "NOT_FOUND",
          "details": "Requested resource not found"
        }
      }
=end