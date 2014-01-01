class EntriesController < ApplicationController
	def index
		# This controller intends to calculate the CDAI score for each day that the user has entered data, and push it to an array that can be used by highcharts
		# For reference: http://en.wikipedia.org/wiki/Crohn%27s_Disease_Activity_Index

		# Big questions:
		# How to deal with missing days (it currently invalidates almost two weeks of scores)

		@entries = current_user.entries

		def today_logged
			# Should return true if the use has already saved an entry for today's date
		end

		def make_scores()
			@entries.map {|e| [e.date, e.score]}
		end

		@dataseries = make_scores()

    # Init highcharts and pass it the array of scores
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=> 'Disease History' })
      f.xAxis(:type => 'datetime')
      f.legend(:enabled => false)
      f.series(:type=> 'areaspline',:name=> 'CDAI Score',:data=> make_scores())
    end
    
    respond_with @entries
	end

	def new
		@entry = Entry.new
	end

	def create
		@entry = Entry.new(params[:entry])
		if @entry.save
			redirect_to @entry
		else
			render :new
		end
	end

	def show
		@entry = Entry.find(params[:id])
	end
end
