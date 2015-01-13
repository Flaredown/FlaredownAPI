class UserTreatment < ActiveRecord::Base

  belongs_to :user, counter_cache: :treatments_count
  belongs_to :treatment

end
