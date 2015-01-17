class User < ActiveRecord::Base
  include TokenAuth::User
  include UserTrackables
  include UserColors

  has_paper_trail :only => %i( locale catalogs symptoms active_symptoms symptoms_count treatments active_treatments treatments_count conditions active_conditions conditions_count )

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :invitable

  def catalogs
    self.conditions.map { |c| CATALOG_CONDITIONS[c.name] }.compact
  end
  def current_catalogs
    self.current_conditions.map { |c| CATALOG_CONDITIONS[c.name] }.compact
  end

  def entries; Entry.by_user_id.key(self.id.to_s); end

  def checked_in_today
    Entry.by_date_and_user_id.key([Date.today,self.id.to_s]).first.present?
  end

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
