class Symptom < ActiveRecord::Base

  #association

  has_many :user_symptoms
  has_many :users, :through => :user_symptoms

  #validations

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates_format_of :name, :with => /^[a-zA-Z0-9\s]+$/


end
