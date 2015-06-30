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
  factory :entry_with_treatments, class: Entry do
    user
    sequence(:date) {|n| (n-1).days.from_now.to_date}
    treatments [
      {name: "Tickles", quantity: "1.0", unit: "session"},
      {name: "Tickles", quantity: "1.0", unit: "session"},
      {name: "Orange Juice", quantity: "1.0", unit: "l"},
    ]

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
      Entry.skip_callback(:save, :after, :enqueue)
      Entry.perform entry.id, false
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
      Entry.skip_callback(:save, :after, :enqueue)
      Entry.perform entry.id, false
      entry.reload
    end

  end
end

FactoryGirl.define do
  factory :symptom_entry, class: Entry do
    user
    catalogs []
    sequence(:date) {|n| (n-1).days.from_now.to_date}
    responses []

    before(:create) do |entry|
      entry.responses << build(:response, {catalog: "symptoms", name: "fat toes"       , value: [*0..4].sample})
      entry.responses << build(:response, {catalog: "symptoms", name: "droopy lips"    , value: [*0..4].sample})
      entry.responses << build(:response, {catalog: "symptoms", name: "slippery tongue", value: [*0..4].sample})
    end
    after(:create) do |entry|
      Entry.skip_callback(:save, :after, :enqueue)
      Entry.perform entry.id, false
      entry.reload
    end

  end
end

FactoryGirl.define do
  factory :condition_entry, class: Entry do
    user
    catalogs []
    sequence(:date) {|n| (n-1).days.from_now.to_date}
    responses []

    before(:create) do |entry|
      entry.responses << build(:response, {catalog: "conditions", name: "Crohn's disease"       , value: [*0..4].sample})
      entry.responses << build(:response, {catalog: "conditions", name: "Depression"    , value: [*0..4].sample})
    end
    after(:create) do |entry|
      Entry.skip_callback(:save, :after, :enqueue)
      Entry.perform entry.id, false
      entry.reload
    end

  end
end

FactoryGirl.define do
  factory :hbi_and_symptoms_entry, class: Entry do
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

      # Some symptoms
      entry.responses << build(:response, {catalog: "symptoms", name: "fat toes"       , value: [*0..4].sample})
      entry.responses << build(:response, {catalog: "symptoms", name: "droopy lips"    , value: [*0..4].sample})
      entry.responses << build(:response, {catalog: "symptoms", name: "slippery tongue", value: [*0..4].sample})

      # some conditions too
      entry.responses << build(:response, {catalog: "conditions", name: "Crohn's disease", value: [*0..4].sample})
      entry.responses << build(:response, {catalog: "conditions", name: "Depression"     , value: [*0..4].sample})

      Entry.class_eval{ include HbiCatalog }
    end
    after(:create) do |entry|
      Entry.skip_callback(:save, :after, :enqueue)
      Entry.perform entry.id, false
      entry.reload
    end

  end
end

FactoryGirl.define do
  factory :response do
    name ""
    value ""
    catalog ""
  end
end
