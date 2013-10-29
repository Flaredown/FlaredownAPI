class EntriesController < ApplicationController
	def index
		# This controller intends to calculate the CDAI score for each day that the user has entered data, and push it to an array that can be used by highcharts
		# For reference: http://en.wikipedia.org/wiki/Crohn%27s_Disease_Activity_Index

		# Big questions:
		# How to deal with missing days (it currently invalidates almost two weeks of scores)

		@entries = Entry.all

		def make_scores()
			@entries.map {|e| [e.date, e.score]}
		end

		# Init highcharts and pass it the array of scores
		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=> 'Disease History' })
			f.xAxis(:type => 'datetime')
			f.legend(:enabled => false)
			f.series(:type=> 'areaspline',:name=> 'CDAI Score',:data=> make_scores())
		end
	end

	def new
	end
end
