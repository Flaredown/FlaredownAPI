class Condition < ActiveRecord::Base
  include TrackableValidations

  has_many :user_conditions
  has_many :users, :through => :user_conditions
end