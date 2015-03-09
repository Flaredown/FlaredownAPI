class V1::Users::SessionsController < Devise::SessionsController
  respond_to :json
  before_filter :ensure_params_exist, :except => [:destroy]
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, :only => :create
  prepend_before_filter :only => [ :create, :destroy ] { request.env["devise.skip_timeout"] = true }

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # Create a new session, take note of parameter name (`v1_`)
  #
  # Examples
  #
  #   curl <domain>/v1/users/sign_in --data "v1_user[email]=test@test.com&v1_user[password]=testing123"
  #
  # Returns current_user in JSON format:
  #
  #   { "id":1, "email":"test@test.com", "authentication_token":"mLqngeD6roA6i6eUsJUj } # other attributes snipped
  def create
    resource = User.find_for_database_authentication(:email=>params[:v1_user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:v1_user][:password])
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, :location => after_sign_in_path_for(resource)
    else
      invalid_login_attempt
    end
  end

  # DELETE /resource/sign_out
  def destroy
    sign_out(resource_name)

    # redirect_path = after_sign_out_path_for(resource_name)
    # signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    # set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    # yield resource if block_given?
    #
    # # We actually need to hardcode this as Rails default responder doesn't
    # # support returning empty response on GET request

    # respond_to do |format|
    #   format.all { head :no_content }
    #   format.any(*navigational_formats) { redirect_to redirect_path }
    # end
    render json: {}, status: 200
  end

  protected
  def ensure_params_exist
    return unless params[:v1_user][:email].blank?
    errors = {email: [{type: 'empty', message: 'Email is empty'}]}
    render :json=>respond_with_error(errors), :status=>401
  end

  def invalid_login_attempt
    warden.custom_failure!
    errors = {email: ["Email is invalid"], password: ["Password is invalid"]}
    render :json=>respond_with_error(errors), :status=>422
  end

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { :methods => methods, :only => [:password] }
  end

  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end

  def respond_with_error(errors)
    generator = GroovyResponseGenerator.new("inline", errors)
    return generator.get_errors_response()
  end
end
