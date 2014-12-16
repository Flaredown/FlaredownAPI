class GroovyResponseGenerator
  def initialize(type, errors)
    @type = type
    @errors = errors
  end

  def get_errors_response
    case @type
      when "inline"
        return getInlineErrorResponse()
    end
  end

  protected

  def getInlineErrorResponse
    fields_errors = steralizeFieldsError()
    response = {
        errors: {
            error_group: @type,
            fields: fields_errors,
            machine_name: "validation_error"
        }
    }

    return response
  end

  def steralizeFieldsError
    errorsHash = {}
    @errors. each do |key, value|
      errors = []
      Rails.logger.debug key
      value.each do |message|
        errorHash = {:type => '', :message => message}
        errors.push errorHash
      end
      errorsHash[key] = errors
    end
    return errorsHash
  end

end
