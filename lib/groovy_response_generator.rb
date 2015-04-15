module GroovyResponseGenerator
  GENERIC_RESPONSES = {
    "404" => ["generic", {title: 404, description: "nice_errors.404"}, 404],
    "406" => ["generic", {title: 406, description: "nice_errors.406"}, 406],
    "407" => ["generic", {title: 407, description: "nice_errors.407"}, 407],
    "408" => ["generic", {title: 408, description: "nice_errors.408"}, 408],
    "409" => ["generic", {title: 409, description: "nice_errors.409"}, 409],
    "410" => ["generic", {title: 410, description: "nice_errors.410"}, 410],
    "411" => ["generic", {title: 411, description: "nice_errors.411"}, 411],
    "412" => ["generic", {title: 412, description: "nice_errors.412"}, 412],
    "413" => ["generic", {title: 413, description: "nice_errors.413"}, 413],
    "414" => ["generic", {title: 414, description: "nice_errors.414"}, 414],
    "415" => ["generic", {title: 415, description: "nice_errors.415"}, 415],
    "416" => ["generic", {title: 416, description: "nice_errors.416"}, 416],
    "417" => ["generic", {title: 417, description: "nice_errors.417"}, 417],
    "418" => ["generic", {title: 418, description: "nice_errors.418"}, 418],
    "420" => ["generic", {title: 420, description: "nice_errors.420"}, 420],
    "422" => ["generic", {title: 422, description: "nice_errors.422"}, 422],
    "423" => ["generic", {title: 423, description: "nice_errors.423"}, 423],
    "424" => ["generic", {title: 424, description: "nice_errors.424"}, 424],
    "426" => ["generic", {title: 426, description: "nice_errors.426"}, 426],
    "428" => ["generic", {title: 428, description: "nice_errors.428"}, 428],
    "429" => ["generic", {title: 429, description: "nice_errors.429"}, 429],
    "431" => ["generic", {title: 431, description: "nice_errors.431"}, 431],
    "444" => ["generic", {title: 444, description: "nice_errors.444"}, 444],
    "449" => ["generic", {title: 449, description: "nice_errors.449"}, 449],
    "450" => ["generic", {title: 450, description: "nice_errors.450"}, 450],
    "451" => ["generic", {title: 451, description: "nice_errors.451"}, 451],
    "499" => ["generic", {title: 499, description: "nice_errors.499"}, 499],
    "500" => ["generic", {title: 500, description: "nice_errors.500"}, 500],
    "501" => ["generic", {title: 501, description: "nice_errors.501"}, 501],
    "502" => ["generic", {title: 502, description: "nice_errors.502"}, 502],
    "503" => ["generic", {title: 503, description: "nice_errors.503"}, 503],
    "504" => ["generic", {title: 504, description: "nice_errors.504"}, 504],
    "505" => ["generic", {title: 505, description: "nice_errors.505"}, 505],
    "506" => ["generic", {title: 506, description: "nice_errors.506"}, 506],
    "507" => ["generic", {title: 507, description: "nice_errors.507"}, 507],
    "508" => ["generic", {title: 508, description: "nice_errors.508"}, 508],
    "509" => ["generic", {title: 509, description: "nice_errors.509"}, 509],
    "510" => ["generic", {title: 510, description: "nice_errors.510"}, 510],
    "511" => ["generic", {title: 511, description: "nice_errors.511"}, 511],
    "598" => ["generic", {title: 598, description: "nice_errors.598"}, 598],
    "599" => ["generic", {title: 599, description: "nice_errors.599"}, 599],
  }

  def render_error(kind, errors={}, code=400, model=nil)
    if errors.is_a?(ActiveModel::Errors)
      model_name ||= errors.instance_variable_get(:@base).class.to_s.underscore
      errors = errors.messages
    end

    case kind
    when "inline"
      inlineErrorResponse(kind, errors, code, model_name)
    when "general"
      generalErrorResponse(kind, errors, code)
    else
      key = kind.to_s
      if GENERIC_RESPONSES.has_key?(key)
        generalErrorResponse(*GENERIC_RESPONSES[key])
      else
        generalErrorResponse(*GENERIC_RESPONSES["500"])
      end
    end
  end

  def render_success(code=200)
    render json: {success: true}, status: code
  end

  def general_error_for(name="general_error", code=400)
    render_error("general", {title: "#{name}", description: "#{name}_description"}, code)
  end

  protected

  def inlineErrorResponse(kind, errors, code, model_name)
    response = {
        errors: {
            kind: kind,
            fields: normalizeFieldErrors(errors, model_name),
            success: false,
            model: model_name,
            machine_name: "validation_error"
        }
    }

    return render :json => response, :status => code
  end

  def generalErrorResponse(kind, error, code)
    response = {
        errors: {
            kind: kind,
            title: error[:title],
            description: error[:description],
            success: false,
            machine_name: "general_error"
        }
    }

    return render :json => response, :status => code
  end


  private
  def normalizeFieldErrors(errors, model_name=nil)

    # EXAMPLES INPUTS:
    # ActiveModel::Errors
    # {email: [{type: 'empty', message: 'Email is empty'}]}
    # {name: "Name cannot be longer then 100 characters"}
    # {name: ["Name cannot be longer then 100 characters", "No special characters!"]}

    # OUTPUT
    # {field: [{type: "sometype", message: "the messsage"}]}

    normalized = errors.reduce({}) do |hash,(key,value)|
      hash[key] = [] # Each key should always give back an Array, start with that

      value.each do |error|
        case error.class.to_s
        when "Hash"
          hash[key].push error # just push it, assume it's type/message format
        when "String"
          hash[key] = [{type: "", message: error}]
        end
      end

      hash
    end

    if model_name then {"#{model_name}" => normalized} else normalized end
  end

end
