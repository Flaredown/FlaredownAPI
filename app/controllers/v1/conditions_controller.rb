class V1::ConditionsController < V1::BaseController
  include TrackableSearch

  def create
    condition = Condition.where('lower(name) = ?', condition_params[:name].downcase).first_or_create(name: condition_params[:name], locale: current_user.locale)

    if condition.valid?
      current_user.user_conditions.activate condition
      render json: {condition: {id: condition.id, name: condition.name}}, status: 201
    else
      render_error("inline", condition.errors)
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
      render_error(404)
    end
  end

  private
  def condition_params
    params.permit(:name)
  end

end