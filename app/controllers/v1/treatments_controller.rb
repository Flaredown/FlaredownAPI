class V1::TreatmentsController < V1::BaseController
  include TrackableSearch

  def create
    treatment = Treatment.where('lower(name) = ?', treatment_params[:name].downcase).first_or_create(name: treatment_params[:name], locale: current_user.locale)

    if treatment.valid?
      current_user.user_treatments.activate(treatment)
      return render json: {treatment: {id: treatment.id, name: treatment.name} }, status: 201
    else
      render_error("inline", treatment.errors)
    end

  end

  def search
    results = search_trackable(treatment_params[:name])
    render json: results.to_json, status: 200
  end

  def destroy
    treatment = Treatment.find_by(id: params[:id])
    if treatment
      current_user.user_treatments.deactivate(treatment)
      render json: {success: true}, status: 204
    else
      render_error(404)
    end
  end

  private
  def treatment_params
    params.permit(:name, :quantity, :unit)
  end
end


