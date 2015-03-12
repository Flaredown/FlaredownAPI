module BasicQuestionTemplate
  def basic_question(name)
    [{
      name: name,
      kind: :select,
      inputs: [
        {value: 0, label: "basic_0", meta_label: "smiley"},
        {value: 1, label: "basic_1", meta_label: nil},
        {value: 2, label: "basic_2", meta_label: nil},
        {value: 3, label: "basic_3", meta_label: nil},
        {value: 4, label: "basic_4", meta_label: nil},
      ]
    }]
  end
end
