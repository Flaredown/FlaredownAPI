class V1::TreatmentsController < V1::BaseController

  def create
    treatment = Treatment.create_with(quantity: treatment_params[:quantity], unit: treatment_params[:unit], locale: current_user.locale).find_or_create_by(name: treatment_params[:name])

    if treatment.valid?
      current_user.activate_treatment(treatment)
      return render json: {active_treatments: current_user.active_treatments.map(&:to_i)}, status: 201
    else
      response = respond_with_error(treatment.errors.messages).to_json
      render json: response, status: 400
    end

  end

  def destroy
    treatment = Treatment.find_by(id: params[:id])
    if treatment
      current_user.deactive_treatment(treatment)
      render json: {success: true}, status: 204
    else
      render json: {success: false}, status: 404
    end
  end

  private
  def treatment_params
    params.permit(:name, :quantity, :unit)
  end
end

