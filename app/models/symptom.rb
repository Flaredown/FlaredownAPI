class Symptom < ActiveRecord::Base
  include TrackableValidations

  has_many :user_symptoms
  has_many :users, :through => :user_symptoms
end
