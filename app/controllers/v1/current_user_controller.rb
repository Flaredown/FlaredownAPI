class V1::CurrentUserController < V1::BaseController
  before_filter :only_current_user, except: [:index]

  # for current user lookup
  def index
    render json: current_user, serializer: CurrentUserSerializer
  end

  def show
    render json: current_user, serializer: CurrentUserSerializer
  end
  private
  def only_current_user
    four_oh_four unless params[:id].to_i == current_user.id
  end
end