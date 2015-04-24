class User < ActiveRecord::Base
  include TokenAuth::User
  include UserColors

  acts_as_taggable_on :tags

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :invitable

  # Hstore "settings"
  def update_settings(update)
    self.update_attributes(settings: self.settings.merge(update))
  end

  has_many :user_conditions, ->{extending TrackableAssociation}
  has_many :conditions, through: :user_conditions
  has_many :active_conditions, -> { where user_conditions: { active: true } }, through: :user_conditions, class_name: "Condition", source: :condition

  has_many :user_treatments, ->{extending TrackableAssociation}
  has_many :treatments, through: :user_treatments
  has_many :active_treatments, -> { where user_treatments: { active: true } }, through: :user_treatments, class_name: "Treatment", source: :treatment

  has_many :user_symptoms, ->{extending TrackableAssociation}
  has_many :symptoms, through: :user_symptoms
  has_many :active_symptoms, -> { where user_symptoms: { active: true } }, through: :user_symptoms, class_name: "Symptom", source: :symptom

  ### AUDITING ###
  has_paper_trail :on => [:update], if: Proc.new { |u| u.auditable == true }
  after_create :create_audit
  attr_accessor :auditable
  def create_audit
    @auditable = true
    touch_with_version
    @auditable = false
  end

  def catalogs; self.conditions.map { |c| CATALOG_CONDITIONS[c.name] }.compact ;end
  def active_catalogs; self.active_conditions.map { |c| CATALOG_CONDITIONS[c.name] }.compact; end

  def entries; Entry.by_user_id.key(self.id.to_s); end

  def checked_in_today
    Entry.by_date_and_user_id.key([Date.today,self.id.to_s]).first.present?
  end

  def setup_first_checkin
    self.create_audit
    # TODO switch back to today after QA
    Entry.new({user_id: self.id, date: Date.parse("Apr-01-2015") }).setup_with_audit!
    # Entry.new({user_id: self.id, date: Date.today }).setup_with_audit!
  end

  def onboarded?; settings["onboarded"] == "true"; end
  def graphable?; settings["graphable"] == "true"; end

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
