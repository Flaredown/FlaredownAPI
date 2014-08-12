class Api::V1::UsersController < Api::V1::BaseController
  before_filter :only_current_user, except: [:index]

  # for current user lookup
  def index
    render json: CurrentUserSerializer.new(current_user).to_json, status: 200
  end

  def show
    render json: current_user, status: 200
  end

  def update
    if current_user.update_attributes(user_params)
      render json: current_user, status: 200
    else
      render json: {:success => false, :errors => current_user.errors}, status: 400
    end
  end

  private
  def user_params
    params.require(:user).permit(
      %i(prefix first_name middle_name last_name suffix phone_home phone_work phone_cell fax role email gender dob password password_confirmation).push(User.preference_definitions.keys.map{|k| "prefers_#{k}".to_sym}).flatten
    )
  end
  def only_current_user
    four_oh_four unless params[:id].to_i == current_user.id
  end
end