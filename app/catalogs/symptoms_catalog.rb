module SymptomsCatalog
  extend ActiveSupport::Concern

  included do |base_class|
    validate :symptoms_response_ranges
    def symptoms_response_ranges
      responses = [] # TODO grab all responses

      responses.each do |response|
        unless [*0..4].include?(response.value)
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][response.name] = "Not within allowed values"
        end
      end

    end

  end

  def symptoms_responses
    responses.select{|r| r.catalog == "symptoms"}
  end

  def filled_symptoms_entry?
    # TODO this could become false on changing active_symptoms... loosen criteria? Only applicable to unscored entries?
    user.active_symptoms.map(&:name) - responses.select{|r| r.catalog == "symptoms"}.map(&:name) == []
  end

  def complete_symptoms_entry?
    filled_symptoms_entry?
  end

  # def setup_symptoms_scoring
  # end


end