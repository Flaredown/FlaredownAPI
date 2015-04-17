class V1::Users::PasswordsController < DeviseController
  include GroovyResponseGenerator

  prepend_before_filter :require_no_authentication

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if self.resource
      render_success
    else
      render_error_for("no_such_email")
    end
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      sign_in(resource_name, resource)
      render_success
    else
      render_error("inline", resource.errors)
    end
  end

  protected
  def after_resetting_password_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    new_session_path(resource_name) if is_navigational_format?
  end


  # Check if proper Lockable module methods are present & unlock strategy
  # allows to unlock resource on password reset
  def unlockable?(resource)
    resource.respond_to?(:unlock_access!) &&
      resource.respond_to?(:unlock_strategy_enabled?) &&
      resource.unlock_strategy_enabled?(:email)
  end

  def translation_scope
    'devise.passwords'
  end

end