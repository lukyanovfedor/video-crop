class BadRequestError < ApplicationError

  STATUS = 400

  DETAILS = {
    invalid_input_data: 'Validation error',
    invalid_restart_status: 'Inquiry can be restarted only with failed status'
  }

  def initialize(code = nil, suspect = nil)
    super(code)
    set_validation_errors(suspect) if suspect
  end

  def set_validation_errors(suspect)
    @fields = {}

    suspect.errors.each do |field, msg|
      @fields[field] = suspect.errors.full_message(field, msg)
    end
  end

end