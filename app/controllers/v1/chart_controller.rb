class V1::ChartController < V1::BaseController  
	def show
    start_date  = Date.parse(params[:start_date])
    end_date    = Date.parse(params[:end_date])
    @chart = CatalogChart.new(current_user.id, ["cdai"], start_date, end_date)
    render json: @chart.catalogs_data, status: 200
	end
end
