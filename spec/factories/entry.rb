def random_boolean
  [true,false].sample
end

FactoryGirl.define do
  factory :entry do  
    user
    stools {[*0..10].sample}
    ab_pain {[*0..3].sample}
    general {[*0..4].sample}
    complication_arthritis random_boolean
    complication_iritis random_boolean
    complication_erythema random_boolean
    complication_fistula random_boolean
    complication_fever random_boolean
    complication_other_fistula random_boolean
    opiates random_boolean
    mass {[*0..5].sample}
    hematocrit {[*40..50].sample}
    weight_current 140
    sequence(:created_at) {|n| (n-1).days.from_now}
  end
  
end
