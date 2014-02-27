module CdaiCatalog
  extend ActiveSupport::Concern
  
  CDAI_QUESTIONS        = %i( complication_arthritis complication_iritis complication_erythema complication_fever complication_fistula complication_other_fistula opiates stools ab_pain general mass hematocrit weight_current weight_typical )
  CDAI_SCORE_COMPONENTS = %i( stools ab_pain general complications opiates mass hematocrit weight_deviation  )
  CDAI_COMPLICATIONS    = %i( complication_arthritis complication_erythema complication_fistula complication_other_fistula complication_iritis )
  CDAI_EXPECTED_USE     = [*1..8]
  # BOOLEAN_QUESTIONS = %i( complication_arthritis complication_iritis complication_erythema complication_fever complication_fistula complication_other_fistula opiates )
  # INTEGER_QUESTIONS = %i( stools ab_pain general mass hematocrit weight_current weight_typical )
  
  included do |base_class|
    base_class.question_names = base_class.question_names | CDAI_QUESTIONS
    
    validate :response_ranges
    def response_ranges
      ranges = [
        ["stools", [*0..50]],
        ["ab_pain", [*0..3]],
        ["general", [*0..4]],
        ["mass", [0,2,5]],
        ["hematocrit", [*0..100]],
        ["weight_current", [*25..500]],
        ["weight_typical", [*25..500]],
      ]
      
      ranges.each do |range|
        response = responses.select{|r| r.name == range[0]}.first
        if response and not range[1].include?(response.value)
          # self.errors.add "responses.#{range[0]}", "Not within allowed values"
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][range[0].to_sym] = "Not within allowed values"
        end
      end
      
    end
    
    validate :response_booleans
    def response_booleans
      %w( complication_arthritis complication_iritis complication_erythema complication_erythema complication_fever complication_other_fistula opiates ).each do |name|
        response = responses.select{|r| r.name == name}.first
        if response and not [0,1].include? response.value
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][name.to_sym] = "Must be true or false"
        end
      end
    end
    
  end
  
  def valid_cdai_entry?
    return false unless last_6_entries.count == 6
    !last_6_entries.map{|e| e.filled_cdai_entry?}.include?(false)
  end
  def filled_cdai_entry?
    (CDAI_QUESTIONS - responses.reduce([]) {|accu, response| (accu << response.name.to_sym) if response.name}) == []
  end
  
  def complete_cdai_entry?
    return false if responses.empty?
    return false unless valid_cdai_entry?
    filled_cdai_entry?
  end
  
  def last_6_entries
		start_date = date - 6.days
		end_date = date - 1.day
		@past_entries = Entry.by_date(startkey: start_date, endkey: end_date).to_a
  end
  
  def setup_cdai_scoring
    last_6_entries
  end
  def cdai_complications_score
    CDAI_COMPLICATIONS.reduce(0) do |sum, question_name|
      sum + (self.send(question_name).zero? ? 20 : 0)
    end
  end
	def cdai_opiates_score
		opiates ? 30 : 0
	end
	def cdai_mass_score
		mass * 10
	end
	def cdai_hematocrit_score
    # TODO add gender specificity here (47 guys/42 gals)
		(46 - hematocrit) * 6
	end
	def cdai_stools_score
		@past_entries.map {|e| e.stools}.reduce(:+) * 2
	end	

	def cdai_ab_pain_score
		@past_entries.map {|e| e.ab_pain}.reduce(:+) * 5
	end	

	def cdai_general_score
		@past_entries.map {|e| e.general}.reduce(:+) * 7
	end	

	def cdai_weight_deviation_score
    # TODO add height/weight options for male/female? See here: http://www.ibdsupport.org.au/cdai-calculator
		factor = ((weight_current - User.find(user_id).weight) / weight_current) * 100
		[factor, -10].max
	end
  
end