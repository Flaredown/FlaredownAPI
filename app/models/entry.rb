class Entry < ActiveRecord::Base
  include Score
  belongs_to :user
  
  validates_inclusion_of :stools, :in => [*0..30], :on => :create, :message => "not within allowed values"
  validates_inclusion_of :ab_pain, :in => [*0..3], :on => :create, :message => "not within allowed values"
  validates_inclusion_of :general, :in => [*0..4], :on => :create, :message => "not within allowed values"

  # stools {[*0..10].sample}
  # ab_pain {[*0..3].sample}
  # general {[*0..4].sample}
  # complication_arthritis random_boolean
  # complication_iritis random_boolean
  # complication_erythema random_boolean
  # complication_fistula random_boolean
  # complication_fever random_boolean
  # complication_other_fistula random_boolean
  # opiates random_boolean
  # mass {[*0..5].sample}
  # hematocrit {[*40..50].sample}
  # weight_current 140

	def date
		created_at.beginning_of_day.to_datetime.to_i*1000
	end

end