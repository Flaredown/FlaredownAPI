class UserCondition < ActiveRecord::Base

  belongs_to :user, counter_cache: :conditions_count
  belongs_to :condition

end
