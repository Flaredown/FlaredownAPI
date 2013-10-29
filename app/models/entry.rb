class Entry < ActiveRecord::Base
   attr_accessible :stools, :ab_pain, :general, :complication_arthritis, :complication_iritis, :complication_erythema, :complication_fistula, :complication_other_fistula, :complication_fever, :opiates, :mass, :hematocrit, :weight_current, :created_at


	def score
		score = 0;

		now = Time.new
		start_range = now.beginning_of_day - 7.days
		end_range = now.end_of_day
		past_entries = Entry.where("created_at >= ? and created_at <= ?", start_range, end_range).all

		# past
		score += stool_score(past_entries)
		score += ab_pain_score(past_entries)
		score += general_score(past_entries)

		score += 20 if past_entries.select {|e| e.complication_fever}.length > 0

		# current
		[:complication_arthritis, :complication_erythema, :complication_fistula, 
		 :complication_other_fistula, :complication_iritis].each do |attr|
			score += 20 if self[attr]
		end

		score += 30 if opiates
		score += mass * 10
		score += (46 - hematocrit) * 6
		score += weight_score

		return score
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

	def weight_expected
		140
	end

	def weight_score
		factor = (weight_current - weight_expected) / weight_current * 100
		[factor, -10].max
	end


	def date
		created_at.to_datetime.to_i*1000
	end

end