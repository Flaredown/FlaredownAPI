def random_boolean
  [true,false].sample
end

FactoryGirl.define do
  factory :entry do  
    user
    sequence(:date) {|n| (n-1).days.from_now}
    
  end
end
FactoryGirl.define do
  factory :cdai_entry, class: Entry do  
    user
    catalogs ["cdai"]
    sequence(:date) {|n| (n-1).days.from_now}

    before(:create) do |entry|
      entry.questions << build(:question, {name: :stools      , response: [*0..10].sample})
      entry.questions << build(:question, {name: :ab_pain     , response: [*0..3].sample})
      entry.questions << build(:question, {name: :general     , response: [*0..4].sample})
      entry.questions << build(:question, {name: :mass        , response: [*0..5].sample})
      entry.questions << build(:question, {name: :hematocrit  , response: [*40..50].sample})

      entry.questions << build(:question, {name: :complication_arthritis      , response: random_boolean})
      entry.questions << build(:question, {name: :complication_iritis         , response: random_boolean})
      entry.questions << build(:question, {name: :complication_erythema       , response: random_boolean})
      entry.questions << build(:question, {name: :complication_fistula        , response: random_boolean})
      entry.questions << build(:question, {name: :complication_fever          , response: random_boolean})
      entry.questions << build(:question, {name: :complication_other_fistula  , response: random_boolean})
      entry.questions << build(:question, {name: :opiates                     , response: random_boolean})
 
      entry.questions << build(:question, {name: :weight_current, response: 140})
      Entry.class_eval{ include CdaiCatalog }
      entry.score_cdai_entry
    end
    
  end
end
FactoryGirl.define do
  factory :question do  
    name ""
    response ""
  end
end
