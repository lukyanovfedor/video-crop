json.video do
  json.duration video.timeline.duration
  json.link video_link video.file.cropped.url
end