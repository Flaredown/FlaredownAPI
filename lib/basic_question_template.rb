module BasicQuestionTemplate
  def basic_question(name, locale)
    I18n.locale = locale
    [{
      name: name,
      kind: :select,
      inputs: [
        {value: 0, label: I18n.t("labels.basic_0"), meta_label: "smiley"},
        {value: 1, label: I18n.t("labels.basic_1"), meta_label: nil},
        {value: 2, label: I18n.t("labels.basic_2"), meta_label: nil},
        {value: 3, label: I18n.t("labels.basic_3"), meta_label: nil},
        {value: 4, label: I18n.t("labels.basic_4"), meta_label: nil},
      ]
    }]
  end
end
