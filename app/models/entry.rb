class Entry < ActiveRecord::Base
   attr_accessible :stools, :ab_pain, :general, :complication_arthritis, :complication_iritis, :complication_erythema, :complication_fistula, :complication_other_fistula, :complication_fever, :opiates, :mass, :hematocrit, :weight_current
end
