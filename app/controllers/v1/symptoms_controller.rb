class V1::SymptomsController < V1::BaseController

  def create
    symtom = Symptom.create(name: params[:name], language: "en")
    if symtom.valid?
      render json: {:message => 'Under Construction'}, status: 201
    else
      render json: symtom.errors.messages.to_json, status: 400
    end

  end

  def search
    render json: {:message => 'Under Construction'}, status: 201
  end

end