class User < ActiveRecord::Base
  require "resque_scheduler"
  include TokenAuth::User
  @queue = :user

  after_create :setup_user_queue

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :invitable
  # validates_numericality_of :weight, :on => :create, :message => "is not a number"
  # validates_inclusion_of :weight, :in => [*0..800], :message => "not within allowed values"
  # validates_inclusion_of :gender, :in => %w( male female ), :message => "not within allowed values"

  has_many :user_symptoms
  has_many :symptoms, :through => :user_symptoms do
    def <<(new_item) # disable duplicate addition
      super( Array(new_item) - proxy_association.owner.symptoms )
    end
  end
  def activate_symptom(symptom)
    self.symptoms << symptom
    self.update_attribute(:active_symptoms, (self.active_symptoms | [symptom.id.to_s]))
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
    self.treatments << treatment
    self.update_attribute(:active_treatments, (self.active_treatments | [treatment.id.to_s]))
  end
  def deactive_treatment(treatment)
    self.update_attribute(:active_treatments, (self.active_treatments - [treatment.id.to_s]))
  end

  # Some more associations
  def entries; Entry.by_user_id.key(self.id.to_s); end
  def current_symptoms; Symptom.where(id: self.active_symptoms.map(&:to_i)); end
  def current_treatments; Treatment.where(id: self.active_treatments.map(&:to_i)); end

  def graph_data
    graph = CatalogGraph.new(self.id, self.catalogs)
    graph.catalogs_data
  end

  def upcoming_catalogs
    REDIS.zrange("#{self.id}:upcoming_catalogs", 0, 1000, with_scores: true)
  end

  def setup_user_queue
    Resque.enqueue_at(Date.tomorrow.to_time, User, self.id)
  end

  def obfuscated_id
    "#{self.id}-#{Digest::SHA1.hexdigest(self.authentication_token).strip}"
  end

  def notify!(event, data)
    Pusher.trigger "notifications_#{obfuscated_id}", event, data
  end

  def self.perform(user_id)
    @user = User.find(user_id)
    @user.upcoming_catalogs.each do |catalog|
      REDIS.zincrby("#{@user.id}:upcoming_catalogs", -1, catalog[0])
    end
    Resque.enqueue_at(Date.tomorrow.to_time, User, @user.id)
  end

end
