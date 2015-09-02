json.inquiries @inquiries do |inq|
  json.partial! 'inquiry', inquiry: inq
end