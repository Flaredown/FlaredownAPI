module ConditionsCatalog
  extend ActiveSupport::Concern

  included do |base_class|
    validate :conditions_response_ranges
    def conditions_response_ranges
      responses = [] # TODO grab all responses

      responses.each do |response|
        unless [nil,*0..4].include?(response.value)
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][response.name] = "Not within allowed values"
        end
      end

    end

  end

  def conditions_responses
    responses.select{|r| r.catalog == "conditions"}
  end

  def filled_conditions_entry?
    # TODO this could become false on changing active_conditions... loosen criteria? Only applicable to unscored entries?
    user.active_conditions.map(&:name) - responses.select{|r| r.catalog == "conditions"}.map(&:name) == []
  end

  def complete_conditions_entry?
    filled_conditions_entry?
  end

  # def setup_symptoms_scoring
  # end


end