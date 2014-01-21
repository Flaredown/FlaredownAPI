FactoryGirl.define do
  factory :question do
    sequence(:name) {|n| "some_question_#{('a'..'z').to_a[n]}" }
    sequence(:section) {|n| n}
    
    trait :select do
      kind "select"
      
      after(:create) do |question|
        QuestionInput.create({question_id: question.id, value: 0, label: "none", meta_label: "happy_face", helper: nil})
        QuestionInput.create({question_id: question.id, value: 1, label: "mild", meta_label: "neutral_face", helper: nil})
        QuestionInput.create({question_id: question.id, value: 2, label: "moderate", meta_label: "frowny_face", helper: nil})
        QuestionInput.create({question_id: question.id, value: 3, label: "severe", meta_label: "sad_face", helper: nil})
      end
    end
    trait :yes_no do
      kind "checkbox"
      # options [
      #   {value: true, label: nil, meta_label: nil,   helper: nil},
      #   {value: false, label: nil, meta_label: nil,   helper: nil}
      # ]
    end
    trait :yes_no do
      kind "yes_no"
      # options [
      #   {value: true, label: "yes", meta_label: nil,   helper: nil},
      #   {value: 1, label: "some",     meta_label: "neutral_face", helper: nil},
      #   {value: 2, label: "medium",   meta_label: "frowny_face",  helper: nil},
      #   {value: 3, label: "so_much",  meta_label: "sad_face",     helper: nil}
      # ]
    end
    trait :input do
      kind "input"
    end
      
  end
end