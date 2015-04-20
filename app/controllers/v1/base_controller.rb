class V1::BaseController < ActionController::Base
  include GroovyResponseGenerator
  include TokenAuth::Controller

  before_filter :authenticate_v1_user!
  before_filter :set_format, except: [:app]

  respond_to :json

  rescue_from StandardError, with: :five_hundred
  def five_hundred(exception)
    Rails.logger.error exception.message
    exception.backtrace.each { |line| Rails.logger.error line }
    Raven.capture_exception(exception)
    render_general_error
  end

  rescue_from ActiveRecord::RecordNotFound, with: :four_oh_four
  def four_oh_four; render_error(404); end

  # Rescue any entry of invalid dates (via Date.parse) and render a json error
  rescue_from ArgumentError, with: :invalid_entry_date
  def invalid_entry_date(e)
    raise e unless e.to_s == "invalid date"
    general_error_for("invalid_date", 400)
  end

  def current_user
    current_v1_user
  end

  private
  def set_format
    request.format = "json"
  end
end