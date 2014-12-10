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
    response = {
        errors: {
            error_group: @type,
            fields: @errors,
            machine_name: "validation_error"
        }
    }

    return response
  end

end