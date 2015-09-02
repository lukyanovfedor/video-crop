json.error do
  json.status @exception.status
  json.title @exception.title
  json.code @exception.code
  json.details @exception.details
  json.fields @exception.fields if @exception.fields
end