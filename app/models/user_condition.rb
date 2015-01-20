class UserCondition < ActiveRecord::Base
  has_paper_trail

  belongs_to :user, counter_cache: :conditions_count
  belongs_to :condition

end
