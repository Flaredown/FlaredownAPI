class EntriesController < ApplicationController
	def index
		def makeScore(s)
			# Get a week of entries
			dataRange = Entry.where(updated_at: (s - 7.day)..s)
			# (Sum of stools attribute values) * weighting factor
			# (Avg of ab_pain attribute values) * weighting factor
			# etc...
			# Sum of prior operations

			# Just to see what the server returned:
			return dataRange
		end
		@output = makeScore(Time.now)
		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=> 'Disease History' })
			f.xAxis(:type => 'datetime')
			f.legend(:enabled => false)
			f.series(:type=> 'area',:name=> 'CDAI Score',:data=> [3, 2, 1, 3, 4])
		end
	end

	def new
	end
end
