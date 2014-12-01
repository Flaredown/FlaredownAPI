def random_boolean
  [0,1].sample
end

FactoryGirl.define do
  factory :entry do
    user
    sequence(:date) {|n| (n-1).days.from_now.to_date}
  end
end

FactoryGirl.define do
  factory :hbi_entry, class: Entry do
    user
    catalogs ["hbi"]
    sequence(:date) {|n| (n-1).days.from_now.to_date}
    responses []

    before(:create) do |entry|
      # setup_hbi_questions

      entry.responses << build(:response, {catalog: "hbi", name: :general_wellbeing , value: [*0..4].sample})
      entry.responses << build(:response, {catalog: "hbi", name: :ab_pain           , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "hbi", name: :stools            , value: [*0..10].sample})
      entry.responses << build(:response, {catalog: "hbi", name: :ab_mass           , value: [*0..3].sample})

      entry.responses << build(:response, {catalog: "hbi", name: :complication_arthralgia       , value: random_boolean})
      entry.responses << build(:response, {catalog: "hbi", name: :complication_uveitis          , value: random_boolean})
      entry.responses << build(:response, {catalog: "hbi", name: :complication_erythema_nodosum , value: random_boolean})
      entry.responses << build(:response, {catalog: "hbi", name: :complication_aphthous_ulcers  , value: random_boolean})
      entry.responses << build(:response, {catalog: "hbi", name: :complication_anal_fissure     , value: random_boolean})
      entry.responses << build(:response, {catalog: "hbi", name: :complication_fistula          , value: random_boolean})
      entry.responses << build(:response, {catalog: "hbi", name: :complication_abscess          , value: random_boolean})

      Entry.class_eval{ include HbiCatalog }
    end
    after(:create) do |entry|
      Entry.perform entry.id
      entry.reload
    end

  end
end

FactoryGirl.define do
  factory :rapid3_entry, class: Entry do
    user
    catalogs ["rapid3"]
    sequence(:date) {|n| (n-1).days.from_now.to_date}
    responses []

    before(:create) do |entry|

      entry.responses << build(:response, {catalog: "rapid3", name: :dress_yourself        , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :get_in_out_of_bed     , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :lift_full_glass       , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :walk_outdoors         , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :wash_and_dry_yourself , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :bend_down             , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :turn_faucet           , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :enter_exit_vehicles   , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :walk_two_miles        , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :play_sports           , value: [*0..3].sample})

      entry.responses << build(:response, {catalog: "rapid3", name: :pain_tolerance        , value: (0..10).step(0.5).to_a.sample})
      entry.responses << build(:response, {catalog: "rapid3", name: :global_estimate       , value: (0..10).step(0.5).to_a.sample})

      Entry.class_eval{ include Rapid3Catalog }
    end
    after(:create) do |entry|
      Entry.perform entry.id
      entry.reload
    end

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

      entry.responses << build(:response, {catalog: "cdai", name: :stools      , value: [*0..10].sample})
      entry.responses << build(:response, {catalog: "cdai", name: :ab_pain     , value: [*0..3].sample})
      entry.responses << build(:response, {catalog: "cdai", name: :general     , value: [*0..4].sample})
      entry.responses << build(:response, {catalog: "cdai", name: :mass        , value: [0,2,5].sample})
      entry.responses << build(:response, {catalog: "cdai", name: :hematocrit  , value: [*40..50].sample})

      entry.responses << build(:response, {catalog: "cdai", name: :complication_arthritis      , value: random_boolean})
      entry.responses << build(:response, {catalog: "cdai", name: :complication_iritis         , value: random_boolean})
      entry.responses << build(:response, {catalog: "cdai", name: :complication_erythema       , value: random_boolean})
      entry.responses << build(:response, {catalog: "cdai", name: :complication_fistula        , value: random_boolean})
      entry.responses << build(:response, {catalog: "cdai", name: :complication_fever          , value: random_boolean})
      entry.responses << build(:response, {catalog: "cdai", name: :complication_other_fistula  , value: random_boolean})
      entry.responses << build(:response, {catalog: "cdai", name: :opiates                     , value: random_boolean})

      entry.responses << build(:response, {catalog: "cdai", name: :weight_current, value: 140})
      entry.responses << build(:response, {catalog: "cdai", name: :weight_typical, value: 150})
      Entry.class_eval{ include CdaiCatalog }
    end
    after(:create) do |entry|
      Entry.perform entry.id
    end

  end
end
FactoryGirl.define do
  factory :response do
    name ""
    value ""
  end
end
