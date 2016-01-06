class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  include TokenAuth::Controller

  respond_to :json
  before_filter :set_format, except: [:app]

  rescue_from ActiveRecord::RecordNotFound, with: :four_oh_four
  def four_oh_four
    respond_with "", status: 404
  end

  def app
  end

  def minimum_client
    render json: {
      ios: {
        major: 0,
        minor: 0
      },
      android: {
        major: 0,
        minor: 0
      },
      locales: 1
    }, status: 200
  end
  protected

  def configure_permitted_parameters
    # Override accepted parameters
    # devise_parameter_sanitizer.for(:accept_invitation) do |u|
    #   u.permit %i(email password password_confirmation invitation_token)
    # end

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit %i(email password password_confirmation)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit %i(email password password_confirmation current_password)
    end

  end

  private
  def set_format
    request.format = "json"
  end

end
