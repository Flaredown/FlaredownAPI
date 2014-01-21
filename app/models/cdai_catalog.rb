# reload!;e=Entry.create(date: Date.today, catalogs:["cdai"])
module CdaiCatalog
  extend ActiveSupport::Concern
  
  CDAI_QUESTIONS    = %i( complication_arthritis complication_iritis complication_erythema complication_fever complication_fistula complication_other_fistula opiates stools ab_pain general mass hematocrit weight_current weight_typical )
  # BOOLEAN_QUESTIONS = %i( complication_arthritis complication_iritis complication_erythema complication_fever complication_fistula complication_other_fistula opiates )
  # INTEGER_QUESTIONS = %i( stools ab_pain general mass hematocrit weight_current weight_typical )
  
  included do |base_class|
    base_class.question_names = base_class.question_names.push(*CDAI_QUESTIONS).uniq
    
    after_save :score_cdai_entry
    
    validate :response_ranges
    def response_ranges
      ranges = [
        ["stools", [*0..50]],
        ["ab_pain", [*0..3]],
        ["general", [*0..4]],
        ["mass", [0,3,5]],
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
        if response and not [true,false].include? response.value
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][name.to_sym] = "Must be true or false"
        end
      end
    end
    
  end
  
  def valid_cdai_entry?
    return false if responses.empty?
    (CDAI_QUESTIONS - responses.reduce([]) {|accu, response| (accu << response.name.to_sym) if response.name}) == []
  end
  
  # def date
  #   created_at.beginning_of_day.to_datetime.to_i#*1000
  # end
  
  def score_cdai_entry
    self.scores << {name: "cdai", value: nil} unless cdai_score.present?
    cdai_score.value = self.calculate_cdai_score if valid_cdai_entry?
    self.save
    # Resque.enqueue(Entry, self.id)
    # REDIS.hset("charts:cdai_score:#{self.user_id}", self.date.to_i, self.score)
  end
    
  # TODO enable Redis/Resque on Heroku to use this code
  # def self.perform(entry_id)
  #   entry = Entry.find_by_id(entry_id)
  #   entry.update_column :score, entry.calculate_cdai_score
  #   REDIS.hset("charts:cdai_score:#{entry.user_id}", entry.date.to_i, entry.score) if entry
  # end
  
  def cdai_score
    self.scores.select{|s| s.name == "cdai"}.first
  end
  def calculate_cdai_score
		tally = 0
    
		start_range = date - 7.days
		end_range = date
		past_entries = Entry.by_date.startkey(start_range).endkey(end_range).to_a

    if past_entries.present?
  		# past
      tally += cdai_stool_score(past_entries)
      tally += cdai_ab_pain_score(past_entries)
      tally += cdai_general_score(past_entries)
            
      tally += 20 if past_entries.select {|e| e.complication_fever}.length > 0
            
      # current
      [:complication_arthritis, :complication_erythema, :complication_fistula, :complication_other_fistula, :complication_iritis].each do |question_name|
        tally += 20 if self.send(question_name)
      end
            
      tally += 30 if opiates
      tally += mass * 10
      tally += (46 - hematocrit) * 6
      tally += cdai_weight_score
    end

		tally
	end

	def cdai_stool_score(past_entries)
		past_entries.
			map {|e| e.stools}.
			inject(:+) * 2
	end	

	def cdai_ab_pain_score(past_entries)
		past_entries.
			map {|e| e.ab_pain}.
			inject(:+) * 5
	end	

	def cdai_general_score(past_entries)
		past_entries.
			map {|e| e.general}.
			inject(:+) * 7
	end	

	def cdai_weight_score
		factor = ((weight_current - User.find(user_id).weight) / weight_current) * 100
		[factor, -10].max
	end
  
end