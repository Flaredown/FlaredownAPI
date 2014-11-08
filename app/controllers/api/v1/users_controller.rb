class Api::V1::UsersController < Api::V1::BaseController
  before_filter :only_current_user, except: %i( index invitee )
  skip_before_filter :authenticate_api_v1_user!, :only => [:invitee]

  # for current user lookup
  def index
    render json: CurrentUserSerializer.new(current_user).to_json, status: 200
  end

  def show
    render json: CurrentUserSerializer.new(current_user).to_json, status: 200
  end

  def invitee
    user = User.find_by_invitation_token(params[:token], true)
    return four_oh_four unless user
    render json: BasicUserSerializer.new(user), status: 200
  end

  private
  def only_current_user
    four_oh_four unless params[:id].to_i == current_user.id
  end
end