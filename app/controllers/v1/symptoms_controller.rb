class V1::SymptomsController < V1::BaseController
  include TrackableSearch

  def create
    symptom = Symptom.create_with(locale: current_user.locale).find_or_create_by(name: symptom_params[:name])

    if symptom.valid?
      current_user.user_symptoms.activate(symptom)
      render json: {active_symptoms: current_user.active_symptoms.map(&:name)}, status: 201
    else
      response = respond_with_error(symptom.errors.messages).to_json
      render json: response, status: 400
    end

  end

  def search
    results = search_trackable(symptom_params[:name])
    render json: results.to_json, status: 200
  end

  def destroy
    symptom = Symptom.find_by(id: params[:id])
    if symptom
      current_user.user_symptoms.deactivate(symptom)
      render json: {success: true}, status: 204
    else
      render json: {success: false}, status: 404
    end
  end


  private
  def symptom_params
    params.permit(:name)
  end

end