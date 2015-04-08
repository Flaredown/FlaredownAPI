class V1::UsersController < V1::BaseController
  before_filter :only_current_user, except: %i( index invitee )
  skip_before_filter :authenticate_v1_user!, :only => [:invitee]

  # for current user lookup
  def index
    render json: CurrentUserSerializer.new(current_user).to_json, status: 200
  end

  def show
    render json: CurrentUserSerializer.new(current_user).to_json, status: 200
  end

  def update
    current_user.update_attributes(user_params)
    render json: {success: true}, status: 200
  end

  def invitee
    user = User.find_by_invitation_token(params[:token], true)
    return four_oh_four unless user
    render json: BasicUserSerializer.new(user), status: 200
  end

  private
  def user_params
    params.permit(settings: [:location, :dobDay, :dobMonth, :dobYear, :sex, :gender, :occupation, :highestEducation, :activityLevel, ethnicOrigin: [] ] )
  end

  def only_current_user
    four_oh_four if params[:id] and params[:id].to_i != current_user.id
  end
end