App.QuestionOption = DS.Model.extend
  value: attr()
  label:      attr("string")
  meta_label: attr("string")
  helper:     attr("string")