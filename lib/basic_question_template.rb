module BasicQuestionTemplate
  def basic_question(name)
    [{
      name: name,
      kind: :select,
      inputs: [
        {value: 0, helper: "basic_0", meta_label: "smiley"},
        {value: 1, helper: "basic_1", meta_label: nil},
        {value: 2, helper: "basic_2", meta_label: nil},
        {value: 3, helper: "basic_3", meta_label: nil},
        {value: 4, helper: "basic_4", meta_label: nil},
      ]
    }]
  end
end
