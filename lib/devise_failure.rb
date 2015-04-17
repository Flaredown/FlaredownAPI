class CustomFailureApp < Devise::FailureApp

  include GroovyResponseGenerator
  protected

  def http_auth_body
    return i18n_message unless request_format
    method = "to_#{request_format}"
    if method == "to_xml"
      { error: i18n_message }.to_xml(root: "errors")
    elsif {}.respond_to?(method)
      error = generalErrorResponse("general", {title: "Error", description: i18n_message}, 401)
      error.send(method)
    else
      i18n_message
    end
  end

end