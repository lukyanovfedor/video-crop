module InquiriesHelper

  def video_link(url)
    request.protocol + request.host_with_port + url
  end

end