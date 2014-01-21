def random_boolean
  [0,1].sample
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
    sequence(:date) {|n| (n-1).days.from_now.to_date}
    responses []
    
    
    before(:create) do |entry|
      setup_cdai_questions
      
      entry.responses << build(:response, {name: :stools      , value: [*0..10].sample})
      entry.responses << build(:response, {name: :ab_pain     , value: [*0..3].sample})
      entry.responses << build(:response, {name: :general     , value: [*0..4].sample})
      entry.responses << build(:response, {name: :mass        , value: [0,3,5].sample})
      entry.responses << build(:response, {name: :hematocrit  , value: [*40..50].sample})
      
      entry.responses << build(:response, {name: :complication_arthritis      , value: random_boolean})
      entry.responses << build(:response, {name: :complication_iritis         , value: random_boolean})
      entry.responses << build(:response, {name: :complication_erythema       , value: random_boolean})
      entry.responses << build(:response, {name: :complication_fistula        , value: random_boolean})
      entry.responses << build(:response, {name: :complication_fever          , value: random_boolean})
      entry.responses << build(:response, {name: :complication_other_fistula  , value: random_boolean})
      entry.responses << build(:response, {name: :opiates                     , value: random_boolean})

      entry.responses << build(:response, {name: :weight_current, value: 140})
      entry.responses << build(:response, {name: :weight_typical, value: 150})
      Entry.class_eval{ include CdaiCatalog }
      entry.score_cdai_entry
    end
    
  end
end
FactoryGirl.define do
  factory :response do  
    name ""
    value ""
  end
end
