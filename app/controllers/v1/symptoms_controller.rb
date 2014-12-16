class V1::SymptomsController < V1::BaseController

  def create
    symtom = Symptom.create(name: params[:name], language: "en")
    if symtom.valid?
      render json: {:message => 'Under Construction'}, status: 201
    else
      response = respond_with_error(symtom.errors.messages).to_json
      render json: response, status: 400
    end

  end

  def search

    symptoms = Symptom.fuzzy_search(name: 'anesthesia')
    symtom_ids = []
    for symptom in symptoms
      symtom_ids.push symptom.id
    end
    ids = symtom_ids.map(&:inspect).join(', ')
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

end

