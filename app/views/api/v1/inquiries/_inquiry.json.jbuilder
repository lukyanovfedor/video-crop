json.inquiry do
  json.id inquiry.id.to_s
  json.state inquiry.state
  json.partial! 'video', video: inquiry.video if inquiry.done?
end
