class V1::BaseController < ActionController::Base

  include TokenAuth::Controller
  before_filter :authenticate_v1_user!
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_format, except: [:app]

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :four_oh_four
  def four_oh_four
    render json: {error: "Not found."}, status: 404
  end

  rescue_from CanCan::AccessDenied, with: :not_authorized
  def not_authorized
    render json: {error: "You are not authorized to access this page."}, status: 401
  end

  def current_user
    current_v1_user
  end

  private
  def set_format
    request.format = "json"
  end

end