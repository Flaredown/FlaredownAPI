class EntriesController < ApplicationController
  before_filter :authenticate_user!
  
	def index
    start_date  = Date.parse(params[:start_date])
    end_date    = Date.parse(params[:end_date])
    @entries = Entry.by_date(startkey: start_date, endkey: end_date)
    render json: @entries.to_a, status: 200
	end

	def create
		@entry = Entry.new(entry_params.merge(user_id: current_user.id, date: Date.today))
    @entry.save
    respond_with @entry
	end
  
	def update
		@entry = current_user.entries.select{|e| e.id == params[:id]}.first
    if @entry.update_attributes(entry_params)
      @entry.enqueue
      render json: {id: @entry.id}, status: 200
    else
      respond_with @entry
    end
	end

	def show
    if params[:by_date]
      date = Date.parse(params[:id])
      @entry = Entry.by_date(key: date).first
      render(json: {id: @entry.try(:id)})
    else
      @entry = Entry.find(params[:id])
      @entry ? respond_with(@entry) : four_oh_four
    end    
	end
  
  private
  def entry_params
    params.require(:entry).permit(
      catalogs: [],
      responses: [:name, :value],
      treatments: [:name]
    )
  end
end
