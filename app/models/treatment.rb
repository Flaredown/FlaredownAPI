class Treatment < ActiveRecord::Base
  include TrackableValidations

  has_many :user_treatments
  has_many :users, :through => :user_treatments
end