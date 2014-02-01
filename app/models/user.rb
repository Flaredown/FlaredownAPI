class User < ActiveRecord::Base
  require "resque_scheduler"
  include TokenAuth::User
  @queue = :user
  
  after_create :setup_user_queue
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable  
  validates_numericality_of :weight, :on => :create, :message => "is not a number"
  validates_inclusion_of :weight, :in => [*0..800], :message => "not within allowed values"
  validates_inclusion_of :gender, :in => %w( male female ), :message => "not within allowed values"
  
  def entries
    Entry.by_user_id.key(self.id.to_s)
  end  
  
  def cdai_score_coordinates
    chart = CatalogChart.new(self.id, "cdai")
    chart.score_coordinates(20.days.ago.to_date, Date.today)
  end
  
  def upcoming_catalogs
    REDIS.zrange("#{self.id}:upcoming_catalogs", 0, 1000, with_scores: true)
  end
  
  def setup_user_queue
    Resque.enqueue_at(Date.tomorrow.to_time, User, self.id)
  end
  
  def self.perform(user_id)
    @user = User.find(user_id)
    @user.upcoming_catalogs.each do |catalog|
      REDIS.zincrby("#{@user.id}:upcoming_catalogs", -1, catalog[0])
    end
    Resque.enqueue_at(Date.tomorrow.to_time, User, @user.id)
  end
  
  def medication_coordinates
    i,j = 0,0
    (cdai_score_coordinates.map do |score|
      {med_id: 1, x: score[:x], label: "Breathing Incense of Eucalyptus", dose: "20 minutes"}
    end[0..-4] |
    cdai_score_coordinates.map do |score|
      i = i+1
      {med_id: 3, x: score[:x], label: "Transcendental Meditation", dose: "4 hours"} if i > 4
    end |
    cdai_score_coordinates.map do |score|
      j = j+1
      {med_id: 2, x: score[:x], label: "Homepathic Bee Toenails", dose: "0.00005 mg"} if j < 7
    end).compact!
  end
  
end
