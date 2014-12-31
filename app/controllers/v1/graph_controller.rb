class V1::GraphController < V1::BaseController
	def show
    start_date  = Date.parse(params[:start_date])
    end_date    = Date.parse(params[:end_date])
    catalogs    = current_user.catalogs | ["symptoms"]
    @graph = CatalogGraph.new(current_user.id, catalogs, start_date, end_date)
    render json: @graph.catalogs_data, status: 200
	end
end
