=begin
  api :POST, '/api/v1/users', 'Create an user'
  api_version '1'
  formats ['json']
  description
    == Response example
    {
      "user": {
        "id": "55e68b2a6102a350a4000001"
      },
      "authorization_token": "a9b0dacdcf058d71d0487d0e05f758fb"
    }
=end