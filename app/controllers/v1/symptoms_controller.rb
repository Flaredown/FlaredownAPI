class V1::SymptomsController < V1::BaseController
  include TrackableSearch

  def create
    symptom = Symptom.where('lower(name) = ?', symptom_params[:name].downcase).first_or_create(name: symptom_params[:name], locale: current_user.locale)

    if symptom.valid?
      current_user.user_symptoms.activate(symptom)
      render json: {symptom: {id: symptom.id, name: symptom.name}}, status: 201
    else
      render_error("inline", symptom.errors)
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
      render_error(404)
    end
  end


  private
  def symptom_params
    params.permit(:name)
  end

end