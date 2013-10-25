class EntriesController < ApplicationController
	def index

		@entries = Entry.all

		def makeScoreArray()

			def makeScore(d)
				score = 0;
				# Sum of stools over the past week, weighting factor 2
				score += Entry.where(created_at: (d - 7.day)..d).sum(:stools) * 2
				# Avg of pain ratings over the past week, weighting factor 5
				score += Entry.where(created_at: (d - 7.day)..d).average(:ab_pain) * 5
				# Avg of general well-being ratings over the past week, weighting factor 7
				score += Entry.where(created_at: (d - 7.day)..d).average(:general) * 7
				# Add 20 for each complication present in latest entry
				score += 20 if Entry.select(:complication_arthritis).where(created_at: d).last
				score += 20 if Entry.select(:complication_erythema).where(created_at: d).last
				score += 20 if Entry.select(:complication_fistula).where(created_at: d).last
				score += 20 if Entry.select(:complication_other_fistula).where(created_at: d).last
				score += 20 if Entry.select(:complication_iritis).where(created_at: d).last
				# Add 20 if fever present in past week
				score += 20 if Entry.where(created_at: (d - 7.day)..d, fever: true).exists?
				# Add 30 if taking opiates in latest entry
				score += 30 if Entry.select(:opiates).where(created_at: d).last
				# Presence of abdominal mass in latest entry, weighting facto 10
				score += Entry.select(:mass).where(created_at: d).last * 10
				# Difference current_hematocrit from statistic norm
				score += (46 - Entry.select(:hematocrit).where(created_at: d).last) * 6
				# Percent deviation current_weight from normal weight
				score += ((Entry.select(:weight_current).where(created_at: d).last - 140)/Entry.select(:weight_current).where(created_at: d).last) * 100
				return score
			end

			
			scoreArray = []
			for entry in @entries
				scoreArray.push(makeScore(entry.created_at))
			end
			return scoreArray

		end

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=> 'Disease History' })
			f.xAxis(:type => 'datetime')
			f.legend(:enabled => false)
			f.series(:type=> 'areaspline',:name=> 'CDAI Score',:data=> makeScoreArray())
		end
	end

	def new
	end
end
