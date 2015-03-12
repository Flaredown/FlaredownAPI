class V1::ConditionsController < V1::BaseController
  include TrackableSearch

  def create
    condition = Condition.where('lower(name) = ?', condition_params[:name].downcase).first_or_create(name: condition_params[:name], locale: current_user.locale)

    if condition.valid?
      current_user.user_conditions.activate condition
      render json: {conditions: current_user.conditions.map(&:name)}, status: 201
    else
      response = respond_with_error(condition.errors.messages).to_json
      render json: response, status: 400
    end

  end

  def search
    results = search_trackable(condition_params[:name])
    render json: results.to_json, status: 200
  end

  def destroy
    condition = Condition.find_by(id: params[:id])
    if condition
      current_user.conditions.delete(condition)
      render json: {success: true}, status: 204
    else
      render json: {success: false}, status: 404
    end
  end

  private
  def condition_params
    params.permit(:name)
  end

end