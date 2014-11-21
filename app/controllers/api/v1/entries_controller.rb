class Api::V1::EntriesController < Api::V1::BaseController

  rescue_from ArgumentError, with: :invalid_entry_date
  def invalid_entry_date(e)
    raise e unless e.to_s == "invalid date"
    render json: {error: "Invalid entry date."}, status: 400
  end

	def index
    start_date  = Date.parse(params[:start_date])
    end_date    = Date.parse(params[:end_date])
    @entries = Entry.by_date(startkey: start_date, endkey: end_date)
    render json: @entries, each_serializer: EntrySerializer, status: 200
	end

	def create
    date = Date.parse(params[:date])

    if (@existing = Entry.by_date(key: date).detect{|e| e.user_id == current_user.id.to_s})
      render json: EntrySerializer.new(@existing), status: 200
    else
      # catalogs inclusion necessary here for module inclusion, TODO replace hardcoded with current_user catalogs
      @entry = Entry.create({user_id: current_user.id, date: date, catalogs: ["hbi"] })
      render json: EntrySerializer.new(@entry, scope: :new), status: 201
    end
	end

	def update
    date = Date.parse(params[:id])
    @entry = Entry.by_date(key: date).detect{|e| e.user_id == current_user.id.to_s}

    if @entry.update_attributes(entry_params)
      @entry.enqueue
      render json: {success: true}, status: 200
    else
      render json: {errors: @entry.errors}, status: 422
    end
	end

	def show
    # if params[:by_date]
      date = Date.parse(params[:id])
      @entry = Entry.by_date(key: date).first
      @entry ? render(json: EntrySerializer.new(@entry)) : four_oh_four
      # render(json: {id: @entry.try(:id)})

    # else
    #   @entry = Entry.find(params[:id])
    #   @entry ? respond_with(:api, :v1, @entry) : four_oh_four
    # end
	end

  private
  def entry_params
    json_params = ActionController::Parameters.new( JSON.parse(params[:entry]) )
    json_params.permit(
      :date,
      catalogs: [],
      responses: [:name, :value],
      treatments: [:name]
    )
  end
end
