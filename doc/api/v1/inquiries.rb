=begin
  api :POST, '/api/v1/inquiries', 'Create inquiry'
  param :timeline[from], Integer, "Start video crop time in seconds"
  param :timeline[to], Integer, "End video crop time in seconds"
  param :file, File, "Video file to crop allowed formats mp4, avi"
  api_version '1'
  formats ['json']
  description
    == Response example
    {
      "inquiry": {
        "id": "55e6909f6102a35168000002",
        "state": "scheduled"
      }
    }
=end

=begin
  api :GET, '/api/v1/inquiries', 'Get inquiries list'
  api_version '1'
  formats ['json']
  description
    == Response example
    {
      "inquiries": [
        {
          "inquiry": {
            "id": "55e6632e6102a34a4a000002",
            "state": "done",
            "video": {
              "duration": 280,
              "link": "http://localhost:3000/uploads/video/55e6632e6102a34a4a000003/cropped_94f69e36-deec-40e3-baf5-30cbad052513.mp4"
            }
          }
        },
        {
          "inquiry": {
            "id": "55e6632e6102a34a4a000002",
            "state": "failed"
          }
        }
      ]
    }
=end

=begin
  api :POST, '/api/v1/inquiries/:id/restart', 'Restart failed inquiry'
  param :id, String, desc: 'inquiry id', required: true
  api_version '1'
  formats ['json']
  description
    == Response example
    {
      "inquiry": {
        "id": "55e6909f6102a35168000002",
        "state": "scheduled"
      }
    }
=end