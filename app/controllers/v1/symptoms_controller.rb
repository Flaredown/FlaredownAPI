class V1::SymptomsController < V1::BaseController

  def create
    symptom = Symptom.create_with(quantity: symptom_params[:quantity], unit: symptom_params[:unit], locale: current_user.locale).find_or_create_by(name: symptom_params[:name])

    if symptom.valid?
      current_user.activate_symptom(symptom)
      render json: {active_symptoms: current_user.active_symptoms.map(&:to_i)}, status: 201
    else
      response = respond_with_error(symptom.errors.messages).to_json
      render json: response, status: 400
    end

  end

  def search

    symptoms = Symptom.fuzzy_search(name: 'anesthesia')
    symptom_ids = []
    for symptom in symptoms
      symptom_ids.push symptom.id
    end
    ids = symptom_ids.map(&:inspect).join(', ')
    catalogs = current_user.catalogs
    catalogs_string = ""
    catalogs.each_with_index do |catalog, index|
      if index == (catalogs.length-1) then
        catalogs_string =  catalogs_string + "'#{catalog}'"
      else
        catalogs_string = catalogs_string + "#{catalog}',"
      end
    end
    overlapping_results = Symptom.where("id IN (#{ids}) and related_catalogs && ARRAY[#{catalogs_string}]")
    overlapping_results_ids = [];
    for overlapping_result in overlapping_results
      overlapping_results_ids.push overlapping_result.id
    end
    results = []
    results = results + overlapping_results
    result_count = overlapping_results.length;
    for symptom in symptoms
      if !overlapping_results_ids.include?(symptom.id)
        if result_count < 10
          results.push symptom
          result_count = result_count + 1
        else
          break
        end
      end
    end
    render json: results.to_json, status: 201
  end

  def destroy
    symptom = Symptom.find_by(id: params[:id])
    if symptom
      current_user.deactivate_symptom(symptom)
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

