class Entry < ActiveRecord::Base
  include Score
  @queue = :entries
  belongs_to :user
  
  validates_inclusion_of :stools,         in: [*0..30],  message: "not within allowed values"
  validates_inclusion_of :ab_pain,        in: [*0..3],   message: "not within allowed values"
  validates_inclusion_of :general,        in: [*0..4],   message: "not within allowed values"
  validates_inclusion_of :mass,           in: [*0..5],   message: "not within allowed values"
  validates_inclusion_of :hematocrit,     in: [*0..100], message: "not within allowed values"
  validates_inclusion_of :weight_current, in: [*25..500], message: "not within allowed values"
  validates :complication_arthritis, :complication_iritis, :complication_erythema, :complication_erythema, :complication_fever, :complication_other_fistula, :opiates,
    inclusion: {in: [true,false],  message: "not within allowed values"}
    
  after_save :calculate_score

	def date
		created_at.beginning_of_day.to_datetime.to_i#*1000
	end
  
  def calculate_score
    self.update_column :score, self.cdai_score
    # Resque.enqueue(Entry, self.id)
    # REDIS.hset("charts:score:#{self.user_id}", self.date.to_i, self.score)
  end
    
  # TODO enable Redis/Resque on Heroku to use this code
  # def self.perform(entry_id)
  #   entry = Entry.find_by_id(entry_id)
  #   entry.update_column :score, entry.cdai_score
  #   REDIS.hset("charts:score:#{entry.user_id}", entry.date.to_i, entry.score) if entry
  # end

end