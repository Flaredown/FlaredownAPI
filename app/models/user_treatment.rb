class UserTreatment < ActiveRecord::Base

  has_paper_trail

  belongs_to :user, counter_cache: :treatments_count
  belongs_to :treatment

end
