class V1::BaseController < ActionController::Base
  include GroovyResponseGenerator
  include TokenAuth::Controller

  before_filter :authenticate_v1_user!
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_format, except: [:app]

  respond_to :json

  rescue_from StandardError, with: :five_hundred
  def five_hundred(exception); Rails.logger.debug exception; render_general_error; end

  rescue_from ActiveRecord::RecordNotFound, with: :four_oh_four
  def four_oh_four; render_error(404); end

  def current_user
    current_v1_user
  end

  private
  def set_format
    request.format = "json"
  end
end