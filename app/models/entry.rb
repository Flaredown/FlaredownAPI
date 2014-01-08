class Entry < ActiveRecord::Base
  include Score
  belongs_to :user
  
  validates_inclusion_of :stools,         in: [*0..30],  message: "not within allowed values"
  validates_inclusion_of :ab_pain,        in: [*0..3],   message: "not within allowed values"
  validates_inclusion_of :general,        in: [*0..4],   message: "not within allowed values"
  validates_inclusion_of :mass,           in: [*0..5],   message: "not within allowed values"
  validates_inclusion_of :hematocrit,     in: [*0..100], message: "not within allowed values"
  validates_inclusion_of :weight_current, in: [*0..500], message: "not within allowed values"
  validates :complication_arthritis, :complication_iritis, :complication_erythema, :complication_erythema, :complication_fever, :complication_other_fistula, :opiates,
    inclusion: {in: [true,false],  message: "not within allowed values"}

	def date
		created_at.beginning_of_day.to_datetime.to_i*1000
	end

end