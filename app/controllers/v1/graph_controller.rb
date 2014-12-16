class V1::GraphController < V1::BaseController
	def show
    start_date  = Date.parse(params[:start_date])
    end_date    = Date.parse(params[:end_date])
    @graph = CatalogGraph.new(current_user.id, ["hbi"], start_date, end_date)
    render json: @graph.catalogs_data, status: 200
	end
end
