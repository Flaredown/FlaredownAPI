module Score
  def cdai_score
		tally = 0

		start_range = created_at.beginning_of_day - 7.days
		end_range = created_at.end_of_day
		past_entries = Entry.where("created_at >= ? and created_at <= ?", start_range, end_range).to_a

		# past
		tally += stool_score(past_entries)
		tally += ab_pain_score(past_entries)
		tally += general_score(past_entries)

		tally += 20 if past_entries.select {|e| e.complication_fever}.length > 0

		# current
		[:complication_arthritis, :complication_erythema, :complication_fistula, :complication_other_fistula, :complication_iritis].each do |attr|
			tally += 20 if self[attr]
		end

		tally += 30 if opiates
		tally += mass * 10
		tally += (46 - hematocrit) * 6
		tally += weight_score

		tally
	end

	def stool_score(past_entries)
		past_entries.
			map {|e| e.stools}.
			inject(:+) * 2
	end	

	def ab_pain_score(past_entries)
		past_entries.
			map {|e| e.ab_pain}.
			inject(:+) * 5
	end	

	def general_score(past_entries)
		past_entries.
			map {|e| e.general}.
			inject(:+) * 7
	end	

	def weight_score
		factor = (weight_current - user.weight) / weight_current * 100
		[factor, -10].max
	end
end