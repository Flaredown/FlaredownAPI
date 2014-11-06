class Api::V1::UsersController < Api::V1::BaseController
  before_filter :only_current_user, except: [:index]

  # for current user lookup
  def index
    render json: CurrentUserSerializer.new(current_user).to_json, status: 200
  end

  def show
    render json: current_user, status: 200
  end

  private
  def only_current_user
    four_oh_four unless params[:id].to_i == current_user.id
  end
end