class User < ActiveRecord::Base
  include TokenAuth::User

  has_paper_trail :only => %i( locale catalogs symptoms active_symptoms symptoms_count treatments active_treatments treatments_count conditions active_conditions conditions_count )

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :invitable

  has_many :user_conditions
  has_many :conditions, :through => :user_conditions do
    def <<(new_item) # disable duplicate addition
      super( Array(new_item) - proxy_association.owner.conditions )
    end
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

  has_many :user_symptoms
  has_many :symptoms, :through => :user_symptoms do
    def <<(new_item) # disable duplicate addition
      super( Array(new_item) - proxy_association.owner.symptoms )
    end
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

  has_many :user_treatments
  has_many :treatments, :through => :user_treatments do
    def <<(new_item) # disable duplicate addition
      super( Array(new_item) - proxy_association.owner.treatments )
    end
  end
  def activate_treatment(treatment)
    ActiveRecord::Base.transaction do
      self.treatments << treatment
      self.update_attribute(:active_treatments, (self.active_treatments | [treatment.id.to_s]))
    end
  end
  def deactive_treatment(treatment)
    self.update_attribute(:active_treatments, (self.active_treatments - [treatment.id.to_s]))
  end

  # Some more associations
  def entries; Entry.by_user_id.key(self.id.to_s); end
  def current_conditions; Condition.where(id: self.active_conditions.map(&:to_i)); end
  def current_symptoms; Symptom.where(id: self.active_symptoms.map(&:to_i)); end
  def current_treatments; Treatment.where(id: self.active_treatments.map(&:to_i)); end

  def graph_data
    graph = CatalogGraph.new(self.id, self.catalogs)
    graph.catalogs_data
  end

  def obfuscated_id
    "#{self.id}-#{Digest::SHA1.hexdigest(self.authentication_token).strip}"
  end

  def notify!(event, data)
    Pusher.trigger "notifications_#{obfuscated_id}", event, data
  end

  # UNUSED CATALOGING QUEUEING STUFF
  # require "resque_scheduler"
  # @queue = :user
  # after_create :setup_user_queue
  # def upcoming_catalogs
  #   REDIS.zrange("#{self.id}:upcoming_catalogs", 0, 1000, with_scores: true)
  # end
  #
  # def setup_user_queue
  #   Resque.enqueue_at(Date.tomorrow.to_time, User, self.id)
  # end
  #
  # def self.perform(user_id)
  #   @user = User.find(user_id)
  #   @user.upcoming_catalogs.each do |catalog|
  #     REDIS.zincrby("#{@user.id}:upcoming_catalogs", -1, catalog[0])
  #   end
  #   Resque.enqueue_at(Date.tomorrow.to_time, User, @user.id)
  # end

end
