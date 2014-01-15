class EntriesController < ApplicationController
  before_filter :authenticate_user!
	def index
		# This controller intends to calculate the CDAI score for each day that the user has entered data, and push it to an array that can be used by highcharts
		# For reference: http://en.wikipedia.org/wiki/Crohn%27s_Disease_Activity_Index

		# Big questions:
		# How to deal with missing days (it currently invalidates almost two weeks of scores)

		@entries = current_user.entries
    respond_with @entries
	end

	def create
		@entry = Entry.new(entry_params.merge(user_id: current_user.id, date: Date.today))
    @entry.save
    respond_with @entry
	end
  
	def update
		@entry = current_user.entries.find(params[:id]).first
    if @entry.update_attributes(entry_params)
      render json: {id: @entry.id}, status: 200
    else
      respond_with @entry
    end
	end

	def show
		@entry = Entry.find(params[:id])
    @entry ? respond_with(@entry) : four_oh_four
	end
  
  private
  def entry_params
    # params[:entry] = JSON.parse(params[:entry])
    
    params.require(:entry).permit(
      catalogs: [],
      questions: [:name, :response],
      treatments: [:name]
    )
  end
end
