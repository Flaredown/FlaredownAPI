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
    responses []

    before(:create) do |entry|
      entry.responses << build(:response, {id: :stools      , value: [*0..10].sample})
      entry.responses << build(:response, {id: :ab_pain     , value: [*0..3].sample})
      entry.responses << build(:response, {id: :general     , value: [*0..4].sample})
      entry.responses << build(:response, {id: :mass        , value: [0,3,5].sample})
      entry.responses << build(:response, {id: :hematocrit  , value: [*40..50].sample})

      entry.responses << build(:response, {id: :complication_arthritis      , value: random_boolean})
      entry.responses << build(:response, {id: :complication_iritis         , value: random_boolean})
      entry.responses << build(:response, {id: :complication_erythema       , value: random_boolean})
      entry.responses << build(:response, {id: :complication_fistula        , value: random_boolean})
      entry.responses << build(:response, {id: :complication_fever          , value: random_boolean})
      entry.responses << build(:response, {id: :complication_other_fistula  , value: random_boolean})
      entry.responses << build(:response, {id: :opiates                     , value: random_boolean})
      
      entry.responses << build(:response, {id: :weight_current, value: 140})
      entry.responses << build(:response, {id: :weight_typical, value: 150})
      Entry.class_eval{ include CdaiCatalog }
      entry.score_cdai_entry
    end
    
  end
end
FactoryGirl.define do
  factory :response do  
    id ""
    value ""
  end
end
