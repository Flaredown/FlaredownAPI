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
    true # we don't care for conditions about completion
  end

  def complete_conditions_entry?
    filled_conditions_entry?
  end
end