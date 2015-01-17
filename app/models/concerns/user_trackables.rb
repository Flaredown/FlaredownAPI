module UserTrackables
  extend ActiveSupport::Concern

  included do
    has_many :user_treatments
    has_many :treatments, :through => :user_treatments do
      def <<(new_item) # disable duplicate addition
        super( Array(new_item) - proxy_association.owner.treatments )
      end
    end

    has_many :user_conditions
    has_many :conditions, :through => :user_conditions do
      def <<(new_item) # disable duplicate addition
        super( Array(new_item) - proxy_association.owner.conditions )
      end
    end

    has_many :user_symptoms
    has_many :symptoms, :through => :user_symptoms do
      def <<(new_item) # disable duplicate addition
        super( Array(new_item) - proxy_association.owner.symptoms )
      end
    end
  end

  def current_conditions; Condition.where(id: self.active_conditions.map(&:to_i)); end
  def current_symptoms; Symptom.where(id: self.active_symptoms.map(&:to_i)); end
  def current_treatments; Treatment.where(id: self.active_treatments.map(&:to_i)); end


  def activate_treatment(treatment)
    ActiveRecord::Base.transaction do
      self.treatments << treatment
      self.update_attribute(:active_treatments, (self.active_treatments | [treatment.id.to_s]))
    end
  end
  def deactivate_treatment(treatment)
    self.update_attribute(:active_treatments, (self.active_treatments - [treatment.id.to_s]))
  end

  def activate_condition(condition)
    ActiveRecord::Base.transaction do
      self.conditions << condition
      self.update_attribute(:active_conditions, (self.active_conditions | [condition.id.to_s]))
    end
  end
  def deactivate_condition(condition)
    self.update_attribute(:active_conditions, (self.active_conditions - [condition.id.to_s]))
  end

  def activate_symptom(symptom)
    ActiveRecord::Base.transaction do
      self.symptoms << symptom
      self.update_attribute(:active_symptoms, (self.active_symptoms | [symptom.id.to_s]))
    end
  end
  def deactivate_symptom(symptom)
    self.update_attribute(:active_symptoms, (self.active_symptoms - [symptom.id.to_s]))
  end
end