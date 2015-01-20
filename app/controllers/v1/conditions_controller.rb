class V1::ConditionsController < V1::BaseController

  def create
    condition = Condition.create_with(locale: current_user.locale).find_or_create_by(name: condition_params[:name])

    if condition.valid?
      current_user.user_conditions.activate condition
      render json: {conditions: current_user.conditions.map(&:name)}, status: 201
    else
      response = respond_with_error(condition.errors.messages).to_json
      render json: response, status: 400
    end

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